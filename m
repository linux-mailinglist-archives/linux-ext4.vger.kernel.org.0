Return-Path: <linux-ext4+bounces-3856-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C44C295AB1A
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53AB1C2414A
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE5316D33F;
	Thu, 22 Aug 2024 02:40:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7007581D;
	Thu, 22 Aug 2024 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294445; cv=none; b=rK8734MAuwrhdtthjAsAwpiopxGaSJYw9FWr/acv4yUWnEzqBJpHQSfWMU1rDqfgEv62oCJAOeX8smXHTKjmTaZ2zMlsoyWOryTdP9ABQVjFKMzyDyNydq5aVZRq+fJSmDJ8TPHQhYs1wEEDiZV7eY/CXzwSs2n1bBSYUvAPziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294445; c=relaxed/simple;
	bh=K7OH9dtixuWwgmSWXNnq1LAzMOh7LDGyrGoAdGNXwko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i5JBnU6wyhbyITHiKw42fvVaZm2NTV0+ieC37Y+uQ3PCzBvDidbb7jjEgmj1OuuhoD58bhFmB0Abd3H4/ZXAP79NgOwcsChlQrQxD04QS6SHI/7tr21kJSH9lHsg2XY4oNnCzhXVXdK+fGM5V0aFl28etHiqZ7rE/j3TC0hPIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq6rG0Sh2z4f3jtX;
	Thu, 22 Aug 2024 10:40:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BBB701A18EE;
	Thu, 22 Aug 2024 10:40:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S22;
	Thu, 22 Aug 2024 10:40:39 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v2 18/25] ext4: get rid of ppath in ext4_split_convert_extents()
Date: Thu, 22 Aug 2024 10:35:38 +0800
Message-Id: <20240822023545.1994557-19-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822023545.1994557-1-libaokun@huaweicloud.com>
References: <20240822023545.1994557-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S22
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar47Gry8CryxWw1fGFykXwb_yoW7GFW7pF
	y7Zr1rCr1UKwnIgryxu3W8Zr1aka1UGFW7ArWxt34FvanFqrnYgF17t3WrtFWrtrW8ua43
	Ar40yFyUC3ZxAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUYl19UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQADBWbFpP9DegAAsG

From: Baokun Li <libaokun1@huawei.com>

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in ext4_split_convert_extents(), the following is
done here:

 * Its caller needs to update ppath if it uses ppath.

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 65 ++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9bbb8def1958..4698f765b8e7 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3700,21 +3700,21 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
  * being filled will be convert to initialized by the end_io callback function
  * via ext4_convert_unwritten_extents().
  *
- * Returns the size of unwritten extent to be written on success.
+ * The size of unwritten extent to be written is passed to the caller via the
+ * allocated pointer. Return an extent path pointer on success, or an error
+ * pointer on failure.
  */
-static int ext4_split_convert_extents(handle_t *handle,
+static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 					struct inode *inode,
 					struct ext4_map_blocks *map,
-					struct ext4_ext_path **ppath,
-					int flags)
+					struct ext4_ext_path *path,
+					int flags, unsigned int *allocated)
 {
-	struct ext4_ext_path *path = *ppath;
 	ext4_lblk_t eof_block;
 	ext4_lblk_t ee_block;
 	struct ext4_extent *ex;
 	unsigned int ee_len;
 	int split_flag = 0, depth;
-	unsigned int allocated = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)map->m_lblk, map->m_len);
@@ -3742,14 +3742,8 @@ static int ext4_split_convert_extents(handle_t *handle,
 		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
 	}
 	flags |= EXT4_GET_BLOCKS_PRE_IO;
-	path = ext4_split_extent(handle, inode, path, map, split_flag, flags,
-				 &allocated);
-	if (IS_ERR(path)) {
-		*ppath = NULL;
-		return PTR_ERR(path);
-	}
-	*ppath = path;
-	return allocated;
+	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
+				 allocated);
 }
 
 static int ext4_convert_unwritten_extents_endio(handle_t *handle,
@@ -3785,11 +3779,14 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 			     inode->i_ino, (unsigned long long)ee_block, ee_len,
 			     (unsigned long long)map->m_lblk, map->m_len);
 #endif
-		err = ext4_split_convert_extents(handle, inode, map, ppath,
-						 EXT4_GET_BLOCKS_CONVERT);
-		if (err < 0)
-			return err;
-		path = ext4_find_extent(inode, map->m_lblk, *ppath, 0);
+		path = ext4_split_convert_extents(handle, inode, map, path,
+						EXT4_GET_BLOCKS_CONVERT, NULL);
+		if (IS_ERR(path)) {
+			*ppath = NULL;
+			return PTR_ERR(path);
+		}
+
+		path = ext4_find_extent(inode, map->m_lblk, path, 0);
 		if (IS_ERR(path)) {
 			*ppath = NULL;
 			return PTR_ERR(path);
@@ -3846,11 +3843,14 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 		  (unsigned long long)ee_block, ee_len);
 
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
-		err = ext4_split_convert_extents(handle, inode, map, ppath,
-				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN);
-		if (err < 0)
-			return err;
-		path = ext4_find_extent(inode, map->m_lblk, *ppath, 0);
+		path = ext4_split_convert_extents(handle, inode, map, path,
+				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
+		if (IS_ERR(path)) {
+			*ppath = NULL;
+			return PTR_ERR(path);
+		}
+
+		path = ext4_find_extent(inode, map->m_lblk, path, 0);
 		if (IS_ERR(path)) {
 			*ppath = NULL;
 			return PTR_ERR(path);
@@ -3916,19 +3916,20 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 
 	/* get_block() before submitting IO, split the extent */
 	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
-		ret = ext4_split_convert_extents(handle, inode, map, ppath,
-					 flags | EXT4_GET_BLOCKS_CONVERT);
-		if (ret < 0) {
-			err = ret;
+		*ppath = ext4_split_convert_extents(handle, inode, map, *ppath,
+				flags | EXT4_GET_BLOCKS_CONVERT, &allocated);
+		if (IS_ERR(*ppath)) {
+			err = PTR_ERR(*ppath);
+			*ppath = NULL;
 			goto out2;
 		}
 		/*
-		 * shouldn't get a 0 return when splitting an extent unless
+		 * shouldn't get a 0 allocated when splitting an extent unless
 		 * m_len is 0 (bug) or extent has been corrupted
 		 */
-		if (unlikely(ret == 0)) {
+		if (unlikely(allocated == 0)) {
 			EXT4_ERROR_INODE(inode,
-					 "unexpected ret == 0, m_len = %u",
+					 "unexpected allocated == 0, m_len = %u",
 					 map->m_len);
 			err = -EFSCORRUPTED;
 			goto out2;
@@ -3989,9 +3990,9 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 		err = -EFSCORRUPTED;
 		goto out2;
 	}
+	allocated = ret;
 
 out:
-	allocated = ret;
 	map->m_flags |= EXT4_MAP_NEW;
 map_out:
 	map->m_flags |= EXT4_MAP_MAPPED;
-- 
2.39.2


