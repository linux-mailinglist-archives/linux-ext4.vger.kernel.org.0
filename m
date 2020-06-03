Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D131ECCDA
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jun 2020 11:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgFCJog (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Jun 2020 05:44:36 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17157 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbgFCJof (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Jun 2020 05:44:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591177466; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=qelmaq0pkwEIu3d+xZVz3BFzuq4wuOuUVrpuk9TMFZ73n2JMBSKsJOlRSqfbnGjHl3vEYFuPLK+eovJ9gYa0ARLynhO5ejNb0k+oSdmzM9TElKQ/p9uhXCqQY2+9gBZ+WPJHU6q3AWHtG/DmuQ9mypgbR05qu35fPngwrTmMX6k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1591177466; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Fuvq/HBzV1tV1tSsQmVZUooYeDxi59K+tWOu59nNxDc=; 
        b=gS36OKGcxXHLpc6+AbgUR2yEezQYNx2t59u1oge0C5S0tM4QB1FuyRuw4oiCMn0qBDMD9X99ET05aJARMgqQ/oMvaUb14hCjdGMiNUNhoQmvrZdUHkf5kGxCX/f9LgQnt4C0SXCrQLE2LL5kS9rXbkYJ6Kq6bI7ICT41SzJWZD4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591177466;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=Fuvq/HBzV1tV1tSsQmVZUooYeDxi59K+tWOu59nNxDc=;
        b=Eo9mMZHXmEAsRW1+PQiUEsw42vfJQzvfxh8orj76Rq89A6A+zNpRBS0wLzVB08UP
        gA5r5y29Ut0SFNhuiCeVpqGFAwN5waTCaYL4NOqLbBAuSwc0gdVCCtlK6WZ32MUOyzC
        /lLlBctNbvyc8mmmztlQsjUkdCsH4qiwkcb7YZPc=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1591177465430772.6652610296833; Wed, 3 Jun 2020 17:44:25 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200603094417.6143-1-cgxu519@mykernel.net>
Subject: [RFC PATCH] ext2: drop cached block when detecting corruption
Date:   Wed,  3 Jun 2020 17:44:17 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently ext2 uses mdcache for deduplication of extended
attribution blocks. However, there is lack of handling for
corrupted blocks, so newly created EAs may still links to
corrupted blocks. This patch tries to drop cached block
when detecting corruption to mitigate the effect.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/xattr.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 943cc469f42f..969521e39753 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -93,6 +93,8 @@ static int ext2_xattr_set2(struct inode *, struct buffer_=
head *,
 =09=09=09   struct ext2_xattr_header *);
=20
 static int ext2_xattr_cache_insert(struct mb_cache *, struct buffer_head *=
);
+static void ext2_xattr_cache_remove(struct mb_cache *cache,
+=09=09=09=09    struct buffer_head *bh);
 static struct buffer_head *ext2_xattr_cache_find(struct inode *,
 =09=09=09=09=09=09 struct ext2_xattr_header *);
 static void ext2_xattr_rehash(struct ext2_xattr_header *,
@@ -237,8 +239,10 @@ ext2_xattr_get(struct inode *inode, int name_index, co=
nst char *name,
 =09entry =3D FIRST_ENTRY(bh);
 =09while (!IS_LAST_ENTRY(entry)) {
 =09=09if (!ext2_xattr_entry_valid(entry, end,
-=09=09    inode->i_sb->s_blocksize))
+=09=09    inode->i_sb->s_blocksize)) {
+=09=09=09ext2_xattr_cache_remove(ea_block_cache, bh);
 =09=09=09goto bad_block;
+=09=09}
=20
 =09=09not_found =3D ext2_xattr_cmp_entry(name_index, name_len, name,
 =09=09=09=09=09=09 entry);
@@ -323,8 +327,10 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, s=
ize_t buffer_size)
 =09entry =3D FIRST_ENTRY(bh);
 =09while (!IS_LAST_ENTRY(entry)) {
 =09=09if (!ext2_xattr_entry_valid(entry, end,
-=09=09    inode->i_sb->s_blocksize))
+=09=09    inode->i_sb->s_blocksize)) {
+=09=09=09ext2_xattr_cache_remove(ea_block_cache, bh);
 =09=09=09goto bad_block;
+=09=09}
 =09=09entry =3D EXT2_XATTR_NEXT(entry);
 =09}
 =09if (ext2_xattr_cache_insert(ea_block_cache, bh))
@@ -407,6 +413,7 @@ int
 ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 =09       const void *value, size_t value_len, int flags)
 {
+=09struct mb_cache *ea_block_cache =3D EA_BLOCK_CACHE(inode);
 =09struct super_block *sb =3D inode->i_sb;
 =09struct buffer_head *bh =3D NULL;
 =09struct ext2_xattr_header *header =3D NULL;
@@ -464,8 +471,11 @@ ext2_xattr_set(struct inode *inode, int name_index, co=
nst char *name,
 =09=09 */
 =09=09last =3D FIRST_ENTRY(bh);
 =09=09while (!IS_LAST_ENTRY(last)) {
-=09=09=09if (!ext2_xattr_entry_valid(last, end, sb->s_blocksize))
+=09=09=09if (!ext2_xattr_entry_valid(last, end,
+=09=09=09    sb->s_blocksize)) {
+=09=09=09=09ext2_xattr_cache_remove(ea_block_cache, bh);
 =09=09=09=09goto bad_block;
+=09=09=09}
 =09=09=09if (last->e_value_size) {
 =09=09=09=09size_t offs =3D le16_to_cpu(last->e_value_offs);
 =09=09=09=09if (offs < min_offs)
@@ -881,6 +891,15 @@ ext2_xattr_cache_insert(struct mb_cache *cache, struct=
 buffer_head *bh)
 =09return error;
 }
=20
+static void
+ext2_xattr_cache_remove(struct mb_cache *cache, struct buffer_head *bh)
+{
+=09lock_buffer(bh);
+=09mb_cache_entry_delete(cache, le32_to_cpu(HDR(bh)->h_hash),
+=09=09=09      bh->b_blocknr);
+=09unlock_buffer(bh);
+}
+
 /*
  * ext2_xattr_cmp()
  *
--=20
2.20.1


