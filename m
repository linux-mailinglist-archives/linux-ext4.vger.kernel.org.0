Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260637CE4EE
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Oct 2023 19:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjJRRly (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Oct 2023 13:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjJRRlq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Oct 2023 13:41:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFB7B0;
        Wed, 18 Oct 2023 10:41:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83C6C433C8;
        Wed, 18 Oct 2023 17:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697650904;
        bh=CebfTX8x0gqnWClXdb2PRiRjob3lBToUpb1yn80x07I=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ixsIePkgd6FqsA4/OTA9y+DP1ZywHc7Sr8eHzCsk+2Jo01xrQdac05wRbts2zVrXc
         C4o0TOGiSxkweFeCUUdfA+iKlqGX4HQZPPZCWCOKfiWi9Uw2kl/nab5pguFYwqx8Ct
         qqWZcVRN9CSoC9SWY3fnIJGi+/4qH3kV8pkaapRaJ+RFoTnardz2xPns8JG21g8oJN
         syy5uIQs3ESM7Q0MoYxYJ4hmMSxmOSV0a5aaoB5lriz1+4wr2V1OVE0iP7JaYyQfkA
         TtsgJXdaS/oQiTQobkbvyPySWa0MnB33bAbS8srOYejBKAHotOjG8J+z20op4bFNXu
         WudM7ZkhM2p/Q==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 18 Oct 2023 13:41:12 -0400
Subject: [PATCH RFC 5/9] fs: have setattr_copy handle multigrain timestamps
 appropriately
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-mgtime-v1-5-4a7a97b1f482@kernel.org>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
In-Reply-To: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3403; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CebfTX8x0gqnWClXdb2PRiRjob3lBToUpb1yn80x07I=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlMBjIhGAfiHKR2+BMhUvK9Je6zSTAJVNLPujGV
 e1DN/iJrxSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZTAYyAAKCRAADmhBGVaC
 FTarEACVylMwhcX6PLK1jzC+Yj+mH5qYypQpchyrOIktUb/AdxXRiWd4sKMRH5DU4sFFxFJHWce
 5f8A/LDi2QaJ6fCzZZBK1cfvoc9XAiFCKu3zpxBEmaq++/tX3P2VzqRWTnfE2tgWmG/aUn4Z2tm
 b2cUog1WhdPXz3ubERRvWNE5WLzgVXFRRtarU/5kEUcrj8ungy2NjdEhUktZQuw8H0+2limB8YS
 qRrTP47cjY2RtdJA1+X+67DLw+bYymJllU7Db9sEu2CAfCTOMOxO2euB+OHR5wChJas4MjGcc6G
 WUdoSjOTPlOoiVrGLu9y9zHcC9VUonbBRmRYxTMcIon/aO+1gap4ByfnVvdt0/UhmmD0+lw2wJO
 G7HUB6PJWXGynG3IpGJorc83Hzi/TSAOc2+zQ/bwZ02IvpHBErXnfh7Nhp7LvyB4nlhJLlvQ43+
 TDqOaNj56qR+wFXSFQ83K/wdzpvk1LLbew3buvB1FzEKWdn8RvUU63enQBXlkZ0iUDy3I8dtMUA
 uWFo0dsHzQMbv6DLYthwF6cJWkmgwEWSCevnwHezl+RA1uT7FSY4RpdjtP99UYzDNh+jqQ6Jbq7
 jmJjT0+Lav0EoWH6NwVtw+QqAPT+fxHW3d5Q91P12s38P2PtFjUndb2Rf7IXNKwdcJV9mgtdc+3
 9sLsvNrKr7s47Jg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The setattr codepath is still using coarse-grained timestamps, even on
multigrain filesystems. To fix this, we need to fetch the timestamp for
ctime updates later, at the point where the assignment occurs in
setattr_copy.

On a multigrain inode, ignore the ia_ctime in the attrs, and always
update the ctime to the current clock value. Update the atime and mtime
with the same value (if needed) unless they are being set to other
specific values, a'la utimes().

Note that we don't want to do this universally however, as some
filesystems (e.g. most networked fs) want to do an explicit update
elsewhere before updating the local inode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index bdf5deb06ea9..1d3e6f562bec 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -275,6 +275,42 @@ int inode_newsize_ok(const struct inode *inode, loff_t offset)
 }
 EXPORT_SYMBOL(inode_newsize_ok);
 
+/**
+ * setattr_copy_mgtime - update timestamps for mgtime inodes
+ * @inode: inode timestamps to be updated
+ * @attr: attrs for the update
+ *
+ * With multigrain timestamps, we need to take more care to prevent races
+ * when updating the ctime. Always update the ctime to the very latest
+ * using the standard mechanism, and use that to populate the atime and
+ * mtime appropriately (unless we're setting those to specific values).
+ */
+static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
+{
+	unsigned int ia_valid = attr->ia_valid;
+	struct timespec64 now;
+
+	/*
+	 * If the ctime isn't being updated then nothing else should be
+	 * either.
+	 */
+	if (!(ia_valid & ATTR_CTIME)) {
+		WARN_ON_ONCE(ia_valid & (ATTR_ATIME|ATTR_MTIME));
+		return;
+	}
+
+	now = inode_set_ctime_current(inode);
+	if (ia_valid & ATTR_ATIME_SET)
+		inode_set_atime_to_ts(inode, attr->ia_atime);
+	else if (ia_valid & ATTR_ATIME)
+		inode_set_atime_to_ts(inode, now);
+
+	if (ia_valid & ATTR_MTIME_SET)
+		inode_set_mtime_to_ts(inode, attr->ia_mtime);
+	else if (ia_valid & ATTR_MTIME)
+		inode_set_mtime_to_ts(inode, now);
+}
+
 /**
  * setattr_copy - copy simple metadata updates into the generic inode
  * @idmap:	idmap of the mount the inode was found from
@@ -307,12 +343,6 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 
 	i_uid_update(idmap, attr, inode);
 	i_gid_update(idmap, attr, inode);
-	if (ia_valid & ATTR_ATIME)
-		inode_set_atime_to_ts(inode, attr->ia_atime);
-	if (ia_valid & ATTR_MTIME)
-		inode_set_mtime_to_ts(inode, attr->ia_mtime);
-	if (ia_valid & ATTR_CTIME)
-		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 		if (!in_group_or_capable(idmap, inode,
@@ -320,6 +350,16 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
 			mode &= ~S_ISGID;
 		inode->i_mode = mode;
 	}
+
+	if (is_mgtime(inode))
+		return setattr_copy_mgtime(inode, attr);
+
+	if (ia_valid & ATTR_ATIME)
+		inode_set_atime_to_ts(inode, attr->ia_atime);
+	if (ia_valid & ATTR_MTIME)
+		inode_set_mtime_to_ts(inode, attr->ia_mtime);
+	if (ia_valid & ATTR_CTIME)
+		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 }
 EXPORT_SYMBOL(setattr_copy);
 

-- 
2.41.0

