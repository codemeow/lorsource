/*
 * Copyright 1998-2022 Linux.org.ru
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */

package ru.org.linux.user

import ru.org.linux.group.Group
import ru.org.linux.section.Section

import java.sql.Timestamp
import scala.beans.BeanProperty
import scala.jdk.CollectionConverters._

case class PreparedUserEvent(@BeanProperty event: UserEvent, messageText: Option[String], topicAuthor: User,
                             commentAuthor: Option[User], bonus: Option[Int], @BeanProperty section: Section,
                             group: Group, tags: Seq[String], lastId: Int, @BeanProperty date: Timestamp,
                             @BeanProperty count: Int = 1) {
  def withSimilar(event: UserEvent): PreparedUserEvent = {
    assume(this.event.unread == event.unread)

    if (event.unread) {
      copy(count = count + 1, lastId = event.id)
    } else {
      copy(count = count + 1, lastId = event.id, date = event.eventDate)
    }
  }

  def getAuthor: User = commentAuthor.getOrElse(topicAuthor)

  def getMessageText: String = messageText.orNull

  def getBonus: Int = bonus.getOrElse(0)

  def getTags:java.util.List[String] = tags.asJava

  def getLink:String = {
    if (event.eventType==UserEventFilterEnum.DELETED) {
      s"${group.getUrl}${event.topicId}"
    } else {
      if (event.cid>0) {
        s"${group.getUrl}${event.topicId}?cid=${event.cid}"
      } else {
        s"${group.getUrl}${event.topicId}"
      }
    }
  }
}
