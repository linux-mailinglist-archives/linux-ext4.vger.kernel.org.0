Return-Path: <linux-ext4+bounces-13428-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDOHB9Xce2kdJAIAu9opvQ
	(envelope-from <linux-ext4+bounces-13428-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jan 2026 23:19:01 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A64A4B53CF
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jan 2026 23:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D35A30059B4
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jan 2026 22:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC2B369219;
	Thu, 29 Jan 2026 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aYKxtJOE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA040361DDF
	for <linux-ext4@vger.kernel.org>; Thu, 29 Jan 2026 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769725132; cv=none; b=XWQvycq8lm2MWwmFNV4J2JXzz5z6W9hH+qBFcWAll72H5BwW5B6ZcLNqbE9zcmD3bU2TXh04MW4emaNToheohcrRnGX0rZXVeihw+37kGdGSlZ0iNG5jcGI0lRH8HcyTajt3YERuvQ9cPZayG2xwTuSM/rAptpIYMZ6AuzdlZ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769725132; c=relaxed/simple;
	bh=TlvGEvp3nQhNKDW6Mja0mCJTqffvP7i+OnPG6PR40Sk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=frgcXGq0lpYKlpCgkBJe31C/2JHXBWcZkNqRDhna1FwgRzBPjfHBBY8hpjVQ1RZ3LL6D8J42skPYfVz57pN10zh1UZgaqDV7t3n59f0ery/uJccC4HWiquqLZ2weJERdwxAfVwIRRjxyZJ9AoVzVe5LKDVRKbypdD+9NSTTxe6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=fail smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aYKxtJOE; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1769725113; x=1769984313;
	bh=Rxmxb8jkKPn9JMMGeDDY/Y/oYUlTb6rcdvEAjefGO1Q=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=aYKxtJOE9UoLJQoM1LcYwyezkn/M/pTMW05ZI3I5auGFnYAsEm3mpyd6R1awK4tl1
	 llMqhUf5wlDoxbQn5cS2h+PE03WYK/D9nA40RLh7NlcmwEyMThc6kS1pA3Rb4m1OqE
	 vxK4x1PfxTuQEcdEXrznX+9JTpozC/cx8puosPa8l4INsmHDE6nyJG/04SuRcdTmZE
	 1bHzjc5NBbzjJqoR5m/rvxP4V9pUXNZiPLn5qq7j8EJv0TUlwnoXM4XmKl9W2CVQhy
	 Zh2NwrZ5NFgbv6yiL388EdTcv+m0yjkhpXdEqrPGJ2+HeauEjPoiLtrKJ8cky7x4F4
	 Q8PaAdiVDzibQ==
Date: Thu, 29 Jan 2026 22:18:27 +0000
To: linux-ext4@vger.kernel.org
From: Daniel Mazon <daniel.mazon@proton.me>
Cc: Daniel Mazon <daniel.mazon@proton.me>
Subject: [PATCH] resize2fs: implement option to modify the inode count
Message-ID: <20260129221637.459315-1-daniel.mazon@proton.me>
Feedback-ID: 172137602:user:proton
X-Pm-Message-ID: 5951d95ff835beeaf5628075997c13278f5f14df
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13428-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.mazon@proton.me,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A64A4B53CF
X-Rspamd-Action: no action

Hello,

This patch creates a new operation in "resize2fs" to modify the inode count=
 of=20
an existing ext4 filesystem independently of the block count.
This is a continuation of this email:=20
https://lore.kernel.org/linux-ext4/20251223044519.GF42033@macsyma.lan/

Until now, the bytes-per-inode ratio was chosen at filesystem creation time=
,=20
and could not be modified afterwards. With this patch, it will be possible =
to=20
increase or decrease the inode count using resize2fs. This operation must b=
e=20
done offline.

Some points:
- the functionality is integrated with no duplication of source code, and i=
n a=20
single binary
- the existing tests "make fullcheck" are all ok
- also added two new tests specific to inode count modification
- I also integrated the suggestion about a signed argument: NNN inodes, +NN=
N=20
inodes or -NNN inodes


Technically, the operations are designed as follows:
- To reduce the inode count, we first calculate the new total count, and th=
en=20
we translate all inodes above that number to lower numbers. This is done us=
ing=20
the existing functions that do the same when shrinking a filesystem. After=
=20
that, we move the inodes "in-place" to the new positions in the existing=20
itables. Finally, we free the remaining space of itables, place them=20
contiguosly in flex_bg systems, and update group stats. This approach shoul=
d=20
work even if no free space is available in the fs.
- To increase the inode count, we allocate new larger inode tables, and mov=
e=20
the existing inodes to those tables. The inode tables must be X blocks=20
contiguous, so we may have a badly fragmented fs where no enough contiguous=
=20
free space exists for the new inode tables. In that case, we move some data=
=20
blocks to make room for the new itables. This is done using the existing=20
functions that move blocks when shrinking a filesystem. We may repeat these=
=20
operations several times if the free space is low, freeing the old inode ta=
bles=20
and allocating the new ones, until all inodes are migrated. Also, the group=
=20
stats are updated.


I have tried to minimize modifications to the existing source code. For mos=
t=20
functions it sufficed to add some specific 'if's when we are running an ino=
de=20
change operation. Only the below two functions have larger changes:
- migrate_ea_block(): Before, this function was only called for the old_fs.=
=20
Now, we may need to call it also for the new_fs, so change the rfs paramete=
r to=20
a pointer to the desired fs. Also, there was a check on the metadata_csum o=
f=20
the new_fs in the previous version. AFAICT, the value of metadata_csum shal=
l be=20
the same for both old and new, no resize2fs operation will change it, so no=
w we=20
just check its value on the fs given as parameter.
- inode_scan_and_fix(): Before, this function used a ext2_inode_scan struct=
ure=20
to scan all inodes in the filesystem and update inode numbers and blocks. T=
his=20
structure was associated with the old_fs only. We may now need to do the sa=
me=20
with the new_fs, so I replaced the ext2_inode_scan with a simple 'for' loop=
 so=20
we can read each inode from a different fs. I replicated the calls to=20
progress_callback inside the loop, with the same conditions as in the scan.=
=20
This allows to get the same results for the existing tests, which remain=20
unmodified. When running the tests in my pc, replacing the inode_scan with =
a=20
simple loop had no performance penalty, and the tests results are still ok.

I tested the patch sending it to myself first. When applying it, there is a=
=20
warning message about trailing white space, but I think it is related only =
to=20
the "expected" stdout in the new tests. This is my first contribution to su=
ch a=20
big project, so I guess there will be many things to improve :)

Regards,
Daniel

Signed-off-by: Daniel Mazon <daniel.mazon@proton.me>
---
 resize/main.c                                 | 507 +++++++++-
 resize/resize2fs.c                            | 951 +++++++++++++++++-
 resize/resize2fs.h                            |  22 +-
 .../expect                                    |  41 +
 .../name                                      |   1 +
 .../script                                    |  76 ++
 .../r_inode_count_increase_almost_full/expect |  35 +
 tests/r_inode_count_increase_almost_full/name |   1 +
 .../r_inode_count_increase_almost_full/script |  67 ++
 9 files changed, 1644 insertions(+), 57 deletions(-)
 create mode 100644 tests/r_inode_count_decrease_translate_number/expect
 create mode 100644 tests/r_inode_count_decrease_translate_number/name
 create mode 100644 tests/r_inode_count_decrease_translate_number/script
 create mode 100644 tests/r_inode_count_increase_almost_full/expect
 create mode 100644 tests/r_inode_count_increase_almost_full/name
 create mode 100644 tests/r_inode_count_increase_almost_full/script

diff --git a/resize/main.c b/resize/main.c
index 08a4bbaf..c5dad457 100644
--- a/resize/main.c
+++ b/resize/main.c
@@ -41,14 +41,18 @@ extern int optind;
=20
 #include "../version.h"
=20
+#ifdef __linux__=09=09=09/* Kludge for debugging */
+#define RESIZE2FS_DEBUG
+#endif
+
 char *program_name;
 static char *device_name, *io_options;
=20
 static void usage (char *prog)
 {
 =09fprintf (stderr, _("Usage: %s [-d debug_flags] [-f] [-F] [-M] [-P] "
-=09=09=09   "[-p] device [-b|-s|new_size] [-S RAID-stride] "
-=09=09=09   "[-z undo_file]\n\n"),
+=09=09=09   "[-p] device [-b|-s|-i [+-]inode_count|new_size] "
+=09=09=09   "[-S RAID-stride] [-z undo_file]\n\n"),
 =09=09 prog ? prog : "resize2fs");
=20
 =09exit (1);
@@ -244,6 +248,403 @@ err:
 =09return retval;
 }
=20
+/*
+ * Check corner case: we want to increase the inode table in
+ * a filesystem with no flex_bg and a very small last group
+ */
+static errcode_t check_space_last_group(ext2_filsys fs,
+=09=09=09=09  unsigned int inode_blocks_per_group)
+{
+
+=09ext2fs_block_bitmap meta_bmap =3D NULL;
+=09blk64_t b;
+=09errcode_t retval =3D 0;
+=09unsigned int movable_blocks =3D 0;
+=09ext2_badblocks_list badblock_list =3D 0;
+
+=09retval =3D
+=09    ext2fs_allocate_block_bitmap(fs, _("meta-data blocks"), &meta_bmap)=
;
+=09if (retval)
+=09=09goto errout;
+
+=09retval =3D mark_table_blocks(fs, meta_bmap);
+=09if (retval)
+=09=09goto errout;
+
+=09retval =3D ext2fs_read_bb_inode(fs, &badblock_list);
+=09if (retval) {
+=09=09fprintf(stderr,
+=09=09    "Error while reading badblock list\n");
+=09=09goto errout;
+=09}
+
+=09for (b =3D ext2fs_group_first_block2(fs, fs->group_desc_count - 1);
+=09     b < ext2fs_blocks_count(fs->super); b++) {
+=09=09if (!ext2fs_test_block_bitmap2(meta_bmap, b)
+=09=09    && !ext2fs_badblocks_list_test(badblock_list, b))
+=09=09=09movable_blocks++;
+=09}
+
+=09if (movable_blocks < inode_blocks_per_group) {
+=09=09fprintf(stderr,"************ STOP ************\n");
+=09=09if (!ext2fs_has_feature_flex_bg(fs->super))
+=09=09=09fprintf(stderr,
+=09=09=09"The filesystem flex_bg feature is not set\n");
+=09=09if (!fs->super->s_log_groups_per_flex)
+=09=09=09fprintf(stderr,"The value of s_log_groups_per_flex is "
+=09=09=09=09"%u\n", fs->super->s_log_groups_per_flex);
+=09=09fprintf(stderr,"The last group only has %u movable blocks\n",
+=09=09       movable_blocks);
+=09=09fprintf(stderr, "This is not enough to allocate a new inode "
+=09=09=09"table of %u blocks\n", inode_blocks_per_group);
+=09=09fprintf(stderr, "Under these conditions, it is not possible "
+=09=09=09"to continue.\n\n");
+=09=09fprintf(stderr,"You may try first one of these options:\n");
+=09=09fprintf(stderr," - Use debugfs to %s%s%s\n",
+=09=09       !ext2fs_has_feature_flex_bg(fs->
+=09=09=09=09=09=09   super) ?
+=09=09       "set the flex_bg feature " : "",
+=09=09       !ext2fs_has_feature_flex_bg(fs->super)
+=09=09       && !fs->super->s_log_groups_per_flex ? "and " : "",
+=09=09       !fs->super->s_log_groups_per_flex ?
+=09=09       "set a value of log_groups_per_flex to 4 in the "
+=09=09       "superblock (default mkfs value)"
+=09=09       : "");
+=09=09fprintf(stderr, " - Use resize2fs to grow the filesystem by "
+=09=09=09"at least %u blocks\n",
+=09=09=09inode_blocks_per_group - movable_blocks);
+=09=09if (fs->group_desc_count > 1)
+=09=09=09fprintf(stderr,
+=09=09=09    " - Use resize2fs to shrink the filesystem to %llu "
+=09=09=09    "blocks, in order to get rid of the last group\n",
+=09=09=09     (blk64_t) EXT2_BLOCKS_PER_GROUP(fs->super) *
+=09=09=09     (fs->group_desc_count - 1));
+=09=09fprintf(stderr, "After that, you can try again to change "
+=09=09=09"the inode count\n");
+=09=09retval =3D 1;
+=09}
+
+ errout:
+=09if (meta_bmap)
+=09=09ext2fs_free_block_bitmap(meta_bmap);
+=09if (badblock_list)
+=09=09ext2fs_badblocks_list_free(badblock_list);
+
+=09return retval;
+}
+
+static ext2_ino_t find_last_used_inode(ext2_filsys fs)
+{
+=09ext2_ino_t ino_num =3D fs->super->s_inodes_count;
+=09if (ext2fs_read_inode_bitmap(fs)) {
+=09=09fprintf(stderr, "Error while reading inode bitmap\n");
+=09=09exit(1);
+=09}
+=09while (ino_num && !ext2fs_test_inode_bitmap2(fs->inode_map, ino_num))
+=09=09ino_num--;
+=09return ino_num;
+}
+
+static ext2_ino_t parse_count_param(char *p, ext2_ino_t current_count)
+{
+=09char type =3D 0;
+=09unsigned long n;
+=09ext2_ino_t res =3D 0;
+=09ext2_ino_t MAX_INODE =3D 0xFFFFFFFF;
+
+=09if (p =3D=3D NULL || p[0] =3D=3D 0 || p[1] =3D=3D 0)
+=09=09return 0;
+
+=09if (p[0] =3D=3D '-' && p[1] >=3D '0' && p[1] <=3D '9') {
+=09=09p++;
+=09=09type =3D '-';
+=09} else if (p[0] =3D=3D '+') {
+=09=09type =3D '+';
+=09}
+
+=09n =3D strtoul(p, NULL, 0);
+
+=09if (n > MAX_INODE || n =3D=3D 0) {
+=09=09fprintf(stderr, "invalid param %s\n", type =3D=3D '-' ? --p : p);
+=09=09return 0;
+=09}
+
+=09if (type =3D=3D '-') {
+=09=09if (current_count <=3D n)
+=09=09=09fprintf(stderr, "the resulting count will be under 0 "
+=09=09=09=09"for param: %s\n", --p);
+=09=09else
+=09=09=09res =3D current_count - n;
+=09} else if (type =3D=3D '+') {
+=09=09if (current_count > MAX_INODE - n)
+=09=09=09fprintf(stderr, "the resulting count will overflow "
+=09=09=09=09"for param: %s\n", p);
+=09=09else
+=09=09=09res =3D current_count + n;
+=09} else {
+=09=09res =3D n;
+=09}
+=09return res;
+}
+
+static errcode_t calculate_new_inodes_per_group(ext2_filsys fs,
+=09=09=09=09=09  ext2_ino_t requested_count,
+=09=09=09=09=09  unsigned int *ipg, int force,
+=09=09=09=09=09  int flags)
+{
+
+=09errcode_t=09retval =3D 0;
+=09int=09=09inode_ratio,
+=09=09=09blocksize =3D EXT2_BLOCK_SIZE(fs->super);
+=09unsigned int=09new_inode_count,
+=09=09=09new_inodes_per_group,
+=09=09=09inode_blocks_per_group_rounded,
+=09=09=09required_inodes,
+=09=09=09max_inode_blocks_per_group;
+=09blk64_t=09=09free_space,
+=09=09=09current_inode_blocks_space,
+=09=09=09new_inode_blocks_space,
+=09=09=09safety_margin;
+
+=09required_inodes =3D fs->super->s_inodes_count
+=09=09=09=09- fs->super->s_free_inodes_count;
+=09max_inode_blocks_per_group =3D blocksize * 8 * EXT2_INODE_SIZE(fs->supe=
r)
+=09=09=09=09=09/ blocksize;
+
+=09/*in KiB */
+=09current_inode_blocks_space =3D ((blk64_t) fs->inode_blocks_per_group)
+=09=09=09=09* fs->group_desc_count * (blocksize / 1024);
+=09free_space =3D ext2fs_free_blocks_count(fs->super) * (blocksize / 1024)=
;
+
+#ifdef RESIZE2FS_DEBUG
+=09if (flags & RESIZE_DEBUG_INODECOUNT) {
+=09=09printf("Current inode blocks per group: %u\n",
+=09=09       fs->inode_blocks_per_group);
+=09=09printf("Current inode count: %u\n", fs->super->s_inodes_count);
+=09=09printf("Current inode ratio: %llu bytes-per-inode\n",
+=09=09       ext2fs_blocks_count(fs->super) * blocksize /
+=09=09       fs->super->s_inodes_count);
+=09=09printf("Current inodes per group: %u\n",
+=09=09=09fs->super->s_inodes_per_group);
+=09=09printf("Current space used by inode tables: ");
+
+=09=09if (current_inode_blocks_space > 1048576) {
+=09=09=09printf("%.2f GiB\n",
+=09=09=09       (double)current_inode_blocks_space / 1048576);
+=09=09} else if (current_inode_blocks_space > 1024) {
+=09=09=09printf("%.2f MiB\n",
+=09=09=09=09(double)current_inode_blocks_space / 1024);
+=09=09} else {
+=09=09=09printf("%.2f KiB\n",
+=09=09=09=09(double)current_inode_blocks_space);
+=09=09}
+
+=09=09printf("\nInodes currently used by the filesystem: %u\n",
+=09=09       required_inodes);
+=09=09printf("Current free space: ");
+=09=09if (free_space > 1048576) {
+=09=09=09printf("%.2f GiB\n", (double)free_space / 1048576);
+=09=09} else if (free_space > 1024) {
+=09=09=09printf("%.2f MiB\n", (double)free_space / 1024);
+=09=09} else {
+=09=09=09printf("%.2f KiB\n", (double)free_space);
+=09=09}
+=09=09printf("\nInode count requested by the user: %u\n\n",
+=09=09=09requested_count);
+=09}
+#endif
+
+=09if (requested_count < EXT2_FIRST_INODE(fs->super) + 1) {
+=09=09fprintf(stderr,
+=09=09    "The requested inode count is too low. Minimum is %u\n\n",
+=09=09     EXT2_FIRST_INODE(fs->super) + 1);
+=09=09return 1;
+=09}
+
+=09new_inodes_per_group =3D ext2fs_div64_ceil(requested_count,
+=09=09=09=09=09=09fs->group_desc_count);
+
+=09/*
+=09 * Finally, make sure the number of inodes per group is a
+=09 * multiple of 8.  This is needed to simplify the bitmap
+=09 * splicing code.
+=09 */
+=09if (new_inodes_per_group < 8)
+=09=09new_inodes_per_group =3D 8;
+=09else {
+=09=09if (new_inodes_per_group % 8) {
+=09=09=09new_inodes_per_group &=3D ~7;
+=09=09=09new_inodes_per_group +=3D 8;
+=09=09}
+=09}
+=09inode_blocks_per_group_rounded =3D
+=09    (((new_inodes_per_group * EXT2_INODE_SIZE(fs->super))
+=09=09+ blocksize - 1) / blocksize);
+
+=09if (ext2fs_has_feature_bigalloc(fs->super)
+=09    && inode_blocks_per_group_rounded > fs->inode_blocks_per_group
+=09    && inode_blocks_per_group_rounded % EXT2FS_CLUSTER_RATIO(fs)) {
+
+=09=09/*When increasing the inode count on a bigalloc fs, the
+=09=09allocation functions will put each inode table in different
+=09=09clusters, ie.: a given cluster cannot be shared by multiple
+=09=09itables. Therefore, make sure the whole cluster is used,
+=09=09otherwise the remaining blocks would be wasted. */
+
+=09=09inode_blocks_per_group_rounded +=3D (EXT2FS_CLUSTER_RATIO(fs) -
+=09=09  (inode_blocks_per_group_rounded % EXT2FS_CLUSTER_RATIO(fs)));
+#ifdef RESIZE2FS_DEBUG
+=09=09if (flags & RESIZE_DEBUG_INODECOUNT)
+=09=09=09printf(
+=09=09=09"New inode blocks per group (after rounding to fill last "
+=09=09=09"itable cluster): %u\n", inode_blocks_per_group_rounded);
+#endif
+
+=09} else {
+#ifdef RESIZE2FS_DEBUG
+=09=09if (flags & RESIZE_DEBUG_INODECOUNT)
+=09=09=09printf(
+=09=09=09"New inode blocks per group (after rounding to fill last "
+=09=09=09"itable block): %u\n", inode_blocks_per_group_rounded);
+#endif
+=09}
+
+=09if (inode_blocks_per_group_rounded < EXT2FS_CLUSTER_RATIO(fs)) {
+=09=09if (ext2fs_has_feature_bigalloc(fs->super)
+=09=09    && inode_blocks_per_group_rounded >
+=09=09    fs->inode_blocks_per_group) {
+=09=09=09printf
+=09=09=09    ("inode_blocks_per_group was %u, forced to %i\n",
+=09=09=09     inode_blocks_per_group_rounded,
+=09=09=09     EXT2FS_CLUSTER_RATIO(fs));
+=09=09=09inode_blocks_per_group_rounded =3D
+=09=09=09    EXT2FS_CLUSTER_RATIO(fs);
+=09=09} else if (inode_blocks_per_group_rounded < 1) {
+=09=09=09printf("inode_blocks_per_group was %u, forced to 1\n",
+=09=09=09       inode_blocks_per_group_rounded);
+=09=09=09inode_blocks_per_group_rounded =3D 1;
+=09=09}
+=09} else {
+=09=09if (inode_blocks_per_group_rounded > max_inode_blocks_per_group)
+=09=09{
+=09=09=09printf
+=09=09=09    ("inode_blocks_per_group was %u, forced to %u as "
+=09=09=09    "the remaining inodes would not be addressable in "
+=09=09=09    "the inode bitmap\n",inode_blocks_per_group_rounded,
+=09=09=09     max_inode_blocks_per_group);
+=09=09=09inode_blocks_per_group_rounded =3D
+=09=09=09=09max_inode_blocks_per_group;
+=09=09}
+=09}
+
+=09if (fs->group_desc_count * ((blk64_t) inode_blocks_per_group_rounded
+=09=09* blocksize / EXT2_INODE_SIZE(fs->super)) > 0xffffffff) {
+=09=09fprintf(stderr,
+=09=09    "ERROR: the new inode count (%llu) is above the max "
+=09=09    "allowed value (%u)\n", fs->group_desc_count *
+=09=09     ((blk64_t) inode_blocks_per_group_rounded * blocksize /
+=09=09      EXT2_INODE_SIZE(fs->super)), 0xffffffff);
+=09=09return 1;
+=09}
+
+=09new_inode_count =3D fs->group_desc_count *
+=09=09(inode_blocks_per_group_rounded * blocksize
+=09=09/ EXT2_INODE_SIZE(fs->super));
+
+=09if (new_inode_count < EXT2_FIRST_INODE(fs->super) + 1) {
+=09=09fprintf(stderr, "The inode count is too low!\n");
+=09=09return 1;
+=09}
+
+=09new_inodes_per_group =3D inode_blocks_per_group_rounded
+=09=09=09* blocksize / EXT2_INODE_SIZE(fs->super);
+
+
+=09if (new_inodes_per_group > EXT2_MAX_INODES_PER_GROUP(fs->super)) {
+=09=09fprintf(stderr,
+=09=09    "ERROR: the new inodes per group is above the max "
+=09=09    "allowed value (%u)\n",
+=09=09    EXT2_MAX_INODES_PER_GROUP(fs->super));
+=09=09return 1;
+=09}
+
+
+=09new_inode_blocks_space =3D ((blk64_t) inode_blocks_per_group_rounded)
+=09=09=09=09* fs->group_desc_count * (blocksize / 1024);
+
+#ifdef RESIZE2FS_DEBUG
+=09if (flags & RESIZE_DEBUG_INODECOUNT) {
+=09=09printf("New inode count: %u\n", new_inode_count);
+=09=09printf("New inode ratio: %llu bytes-per-inode\n",
+=09=09         ext2fs_blocks_count(fs->super) * blocksize
+=09=09         / new_inode_count);
+=09=09printf("New inodes per group: %u\n", new_inodes_per_group);
+=09=09printf("New space used by inode tables: ");
+=09=09if (new_inode_blocks_space > 1048576) {
+=09=09printf("%.2f GiB\n", (double)new_inode_blocks_space / 1048576);
+=09=09} else if (new_inode_blocks_space > 1024) {
+=09=09=09printf("%.2f MiB\n",
+=09=09=09=09(double)new_inode_blocks_space / 1024);
+=09=09} else {
+=09=09=09printf("%.2f KiB\n",
+=09=09=09=09(double)new_inode_blocks_space);
+=09=09}
+=09=09printf("\n");
+=09}
+#endif
+
+=09if (required_inodes > new_inode_count) {
+=09=09fprintf(stderr, "The chosen inode count will not provide "
+=09=09=09"enough inodes for the existing filesystem, please "
+=09=09=09"choose a higher inode count\n");
+=09=09return 1;
+=09}
+
+=09if (new_inode_count =3D=3D fs->super->s_inodes_count) {
+=09=09printf("The existing filesystem already has %u inodes. "
+=09=09=09"No change needed.\n", new_inode_count);
+=09=09*ipg =3D new_inodes_per_group;
+=09=09return 0;
+=09}
+
+=09if (new_inode_count > fs->super->s_inodes_count) {
+=09/* this safety_margin shall be much more than enough */
+=09=09safety_margin =3D new_inode_blocks_space / 2;
+=09=09if (new_inode_blocks_space + safety_margin > free_space) {
+=09=09=09if (new_inode_blocks_space - current_inode_blocks_space
+=09=09=09=09>=3D free_space) {
+=09=09=09=09fprintf(stderr, "The free space in the "
+=09=09=09=09"filesystem is too low to perform the change:"
+=09=09=09=09"\nIt will not be possible to allocate large "
+=09=09=09=09"enough inode tables for the chosen inode "
+=09=09=09=09"count\n");
+=09=09=09=09return 1;
+=09=09=09}
+=09=09=09printf
+=09=09=09    ("The filesystem doesn't have enough free space "
+=09=09=09    "to perform the change in a safe way.\n");
+=09=09=09if (force) {
+=09=09=09=09printf("As the force flag has been provided,"
+=09=09=09=09    " we will proceed with the change\n");
+=09=09=09} else {
+=09=09=09=09printf("Re-run with the force flag if you "
+=09=09=09=09    "want to try anyway.\n");
+=09=09=09=09return 1;
+=09=09=09}
+=09=09}
+
+=09=09if (!ext2fs_has_feature_flex_bg(fs->super)
+=09=09    || !fs->super->s_log_groups_per_flex) {
+=09=09=09retval =3D check_space_last_group(fs,
+=09=09=09=09inode_blocks_per_group_rounded);
+=09=09}
+=09}
+
+=09*ipg =3D new_inodes_per_group;
+=09return retval;
+
+}
+
 int main (int argc, char ** argv)
 {
 =09errcode_t=09retval;
@@ -270,6 +671,9 @@ int main (int argc, char ** argv)
 =09long=09=09sysval;
 =09int=09=09len, mount_flags;
 =09char=09=09*mtpt, *undo_file =3D NULL;
+=09ext2_ino_t      last_used_inode, new_inode_count =3D 0;
+=09unsigned int=09new_inodes_per_group =3D 0;
+=09char=09=09*inode_count_param =3D 0;
=20
 #ifdef ENABLE_NLS
 =09setlocale(LC_MESSAGES, "");
@@ -288,7 +692,7 @@ int main (int argc, char ** argv)
 =09else
 =09=09usage(NULL);
=20
-=09while ((c =3D getopt(argc, argv, "d:fFhMPpS:bsz:")) !=3D EOF) {
+=09while ((c =3D getopt(argc, argv, "d:fFhMPpS:bsz:i:")) !=3D EOF) {
 =09=09switch (c) {
 =09=09case 'h':
 =09=09=09usage(program_name);
@@ -323,6 +727,9 @@ int main (int argc, char ** argv)
 =09=09case 'z':
 =09=09=09undo_file =3D optarg;
 =09=09=09break;
+=09=09case 'i':
+=09=09=09inode_count_param =3D optarg;
+=09=09=09break;
 =09=09default:
 =09=09=09usage(program_name);
 =09=09}
@@ -528,8 +935,9 @@ int main (int argc, char ** argv)
 =09=09if (sys_page_size > blocksize)
 =09=09=09new_size &=3D ~((blk64_t)((sys_page_size / blocksize)-1));
 =09}
-=09/* If changing 64bit, don't change the filesystem size. */
-=09if (flags & (RESIZE_DISABLE_64BIT | RESIZE_ENABLE_64BIT)) {
+=09/* If changing 64bit or the inode count, don't change the filesystem si=
ze. */
+=09if ((flags & (RESIZE_DISABLE_64BIT | RESIZE_ENABLE_64BIT)) ||
+=09=09inode_count_param !=3D 0) {
 =09=09new_size =3D ext2fs_blocks_count(fs->super);
 =09}
 =09if (!ext2fs_has_feature_64bit(fs->super)) {
@@ -628,6 +1036,72 @@ int main (int argc, char ** argv)
 =09=09=09=09"feature.\n"));
 =09=09=09goto errout;
 =09=09}
+=09} else if (inode_count_param !=3D 0) {
+                if (mount_flags & EXT2_MF_MOUNTED) {
+                        fprintf(stderr, _("Cannot change the inode count "
+                                "while the filesystem is mounted.\n"));
+                        goto errout;
+                }
+
+=09=09new_inode_count =3D parse_count_param(inode_count_param,
+=09=09=09=09=09=09  fs->super->s_inodes_count);
+=09=09if (!new_inode_count)
+=09=09=09goto errout;
+
+=09=09retval =3D calculate_new_inodes_per_group(fs, new_inode_count,
+=09=09=09=09=09=09   &new_inodes_per_group,
+=09=09=09=09=09=09   force, flags);
+=09=09if (retval)
+=09=09=09goto errout;
+=09=09if (new_inodes_per_group =3D=3D fs->super->s_inodes_per_group)
+=09=09=09goto success_exit;
+
+=09=09if (ext2fs_has_feature_stable_inodes(fs->super)) {
+=09=09=09if (new_inodes_per_group >
+=09=09=09    fs->super->s_inodes_per_group) {
+=09=09=09=09if (force) {
+=09=09=09=09=09printf("Increasing inode count in a "
+=09=09=09=09=09"filesystem with stable_inodes, because"
+=09=09=09=09=09" the force flag is passed\n");
+=09=09=09=09} else {
+=09=09=09=09=09fprintf(stderr, "Asked to increase the "
+=09=09=09=09=09"inode count in a filesystem with "
+=09=09=09=09=09"stable_inodes feature flag.\nPlease "
+=09=09=09=09=09"note it might not be possible to "
+=09=09=09=09=09"reduce the inode count later because "
+=09=09=09=09=09"of this flag.\nRestart with force "
+=09=09=09=09=09"flag to proceed\n");
+=09=09=09=09=09goto errout;
+=09=09=09=09}
+=09=09=09} else {
+=09=09=09=09last_used_inode =3D find_last_used_inode(fs);
+=09=09=09=09if (new_inodes_per_group *
+=09=09=09=09    fs->group_desc_count < last_used_inode) {
+=09=09=09=09=09fprintf(stderr, "Cannot reduce inode "
+=09=09=09=09=09"count in this filesystem because it "
+=09=09=09=09=09"has the stable_inodes feature flag "
+=09=09=09=09=09"and the used inode with the highest "
+=09=09=09=09=09"number is %u, while the resulting "
+=09=09=09=09=09"filesystem would have %u inodes.\n",
+=09=09=09=09=09last_used_inode, new_inodes_per_group *
+=09=09=09=09=09=09=09fs->group_desc_count);
+=09=09=09=09=09goto errout;
+=09=09=09=09}
+=09=09=09=09fprintf(stderr, "Reducing inode count in a "
+=09=09=09=09"filesystem with stable_inodes feature flag."
+=09=09=09=09"\nThe used inode with the highest number is "
+=09=09=09=09"%u. The resulting filesystem will have %u "
+=09=09=09=09"inodes.\n", last_used_inode,
+=09=09=09=09new_inodes_per_group * fs->group_desc_count);
+=09=09=09}
+=09=09}
+
+=09=09flags |=3D
+=09=09    (new_inodes_per_group >
+=09=09     fs->super->s_inodes_per_group) ?
+=09=09     RESIZE_INCREASE_INODE_COUNT :
+=09=09     RESIZE_DECREASE_INODE_COUNT;
+
 =09} else {
 =09=09adjust_new_size(fs, &new_size);
 =09=09if (new_size =3D=3D ext2fs_blocks_count(fs->super)) {
@@ -639,6 +1113,12 @@ int main (int argc, char ** argv)
 =09=09=09goto success_exit;
 =09=09}
 =09}
+=09if (flags & (RESIZE_INCREASE_INODE_COUNT | RESIZE_DECREASE_INODE_COUNT)=
 &&
+=09    flags & (RESIZE_ENABLE_64BIT | RESIZE_DISABLE_64BIT)) {
+=09=09fprintf(stderr,
+=09=09_("Cannot change 64-bits mode and inode count simultaneously\n"));
+=09=09goto errout;
+=09}
 =09if ((flags & RESIZE_ENABLE_64BIT) &&
 =09    ext2fs_has_feature_64bit(fs->super)) {
 =09=09fprintf(stderr, _("The filesystem is already 64-bit.\n"));
@@ -663,12 +1143,15 @@ int main (int argc, char ** argv)
 =09=09=09printf(_("Converting the filesystem to 64-bit.\n"));
 =09=09else if (flags & RESIZE_DISABLE_64BIT)
 =09=09=09printf(_("Converting the filesystem to 32-bit.\n"));
+=09=09else if (flags & (RESIZE_INCREASE_INODE_COUNT
+=09=09=09=09| RESIZE_DECREASE_INODE_COUNT))
+=09=09=09printf(_("Changing inode count on the filesystem.\n"));
 =09=09else
 =09=09=09printf(_("Resizing the filesystem on "
 =09=09=09=09 "%s to %llu (%dk) blocks.\n"),
 =09=09=09       device_name, (unsigned long long) new_size,
 =09=09=09       blocksize / 1024);
-=09=09retval =3D resize_fs(fs, &new_size, flags,
+=09=09retval =3D resize_fs(fs, &new_size, new_inodes_per_group, flags,
 =09=09=09=09   ((flags & RESIZE_PERCENT_COMPLETE) ?
 =09=09=09=09    resize_progress_func : 0));
 =09}
@@ -682,8 +1165,16 @@ int main (int argc, char ** argv)
 =09=09=09device_name);
 =09=09goto errout;
 =09}
-=09printf(_("The filesystem on %s is now %llu (%dk) blocks long.\n\n"),
-=09       device_name, (unsigned long long) new_size, blocksize / 1024);
+=09if (flags & (RESIZE_INCREASE_INODE_COUNT | RESIZE_DECREASE_INODE_COUNT)=
) {
+=09=09printf(_("The filesystem on %s now has %u inodes.\n\n"),
+=09=09       device_name,
+=09=09       new_inodes_per_group * fs->group_desc_count);
+=09} else {
+=09=09printf(_
+=09=09       ("The filesystem on %s is now %llu (%dk) blocks long.\n\n"),
+=09=09       device_name, (unsigned long long)new_size,
+=09=09       blocksize / 1024);
+=09}
=20
 =09if ((st_buf.st_size > new_file_size) &&
 =09    (fd > 0)) {
diff --git a/resize/resize2fs.c b/resize/resize2fs.c
index c8964af5..b15fadd3 100644
--- a/resize/resize2fs.c
+++ b/resize/resize2fs.c
@@ -32,6 +32,33 @@
  * =094.  Update the directory blocks with the new inode locations.
  * =095.  Move the inode tables, if necessary.
  */
+ /*
+ * Reducing the inode count consists of the following phases:
+ *
+ *=091.  Calculate the new maximum inode number
+ *=092.  Move the inodes in use above that number to lower numbers
+ *      =092.a. For those inodes, update the references in folders entries
+ *=093.  Reset stats for groups in new fs
+ *=094.  Migrate all the inodes to the new reduced inodes tables
+ *=095.  Free the remaining space. For flex_bg filesystems, try
+ *=09=09to place the new inode tables contiguously
+ *
+ */
+ /*
+ * Increasing the inode count consists of the following phases:
+ *
+ *=091.  Reset stats for groups in new fs
+ *=092.  Allocate new larger inode tables
+ *=093.  Migrate inodes to the new itables
+ *=094.  Free the space of the old itables
+ *=095.  If there were no contiguous free blocks to allocate
+ *=09    some of the new itables:
+ *=09=095.a  Move some data blocks to make room for them
+ *=09=095.b  Update references to those data blocks
+ *=09=09     in the affected files/folders
+ *=09=095.c  Go back to step 2 for the new itables pending allocation
+ *
+ */
=20
 #include "config.h"
 #include "resize2fs.h"
@@ -52,14 +79,16 @@ static errcode_t fix_resize_inode(ext2_filsys fs);
 static errcode_t fix_orphan_file_inode(ext2_filsys fs);
 static errcode_t resize2fs_calculate_summary_stats(ext2_filsys fs);
 static errcode_t fix_sb_journal_backup(ext2_filsys fs);
-static errcode_t mark_table_blocks(ext2_filsys fs,
-=09=09=09=09   ext2fs_block_bitmap bmap);
 static errcode_t clear_sparse_super2_last_group(ext2_resize_t rfs);
 static errcode_t reserve_sparse_super2_last_group(ext2_resize_t rfs,
 =09=09=09=09=09=09 ext2fs_block_bitmap meta_bmap);
 static errcode_t resize_group_descriptors(ext2_resize_t rfs, blk64_t new_s=
ize);
 static errcode_t move_bg_metadata(ext2_resize_t rfs);
 static errcode_t zero_high_bits_in_inodes(ext2_resize_t rfs);
+static errcode_t move_inodes_to_smaller_tables(ext2_resize_t rfs);
+static errcode_t init_increase_inode_count(ext2_resize_t rfs);
+static errcode_t allocate_new_itables(ext2_resize_t rfs);
+static errcode_t make_room_for_new_itables(ext2_resize_t rfs);
=20
 /*
  * Some helper functions to check if a block is in a metadata area
@@ -95,7 +124,8 @@ static int lazy_itable_init;
 /*
  * This is the top-level routine which does the dirty deed....
  */
-errcode_t resize_fs(ext2_filsys fs, blk64_t *new_size, int flags,
+errcode_t resize_fs(ext2_filsys fs, blk64_t *new_size,
+=09    unsigned int new_inodes_per_group, int flags,
 =09    errcode_t (*progress)(ext2_resize_t rfs, int pass,
 =09=09=09=09=09  unsigned long cur,
 =09=09=09=09=09  unsigned long max_val))
@@ -116,6 +146,7 @@ errcode_t resize_fs(ext2_filsys fs, blk64_t *new_size, =
int flags,
 =09rfs->old_fs =3D fs;
 =09rfs->flags =3D flags;
 =09rfs->itable_buf=09 =3D 0;
+=09rfs->new_inodes_per_group =3D new_inodes_per_group;
 =09rfs->progress =3D progress;
=20
 =09init_resource_track(&overall_track, "overall resize2fs", fs->io);
@@ -169,6 +200,24 @@ errcode_t resize_fs(ext2_filsys fs, blk64_t *new_size,=
 int flags,
=20
 =09*new_size =3D ext2fs_blocks_count(rfs->new_fs->super);
=20
+=09init_resource_track(&rtrack, "init_increase_inode_count", fs->io);
+=09init_increase_inode_count(rfs);
+=09if (retval)
+=09=09goto errout;
+=09print_resource_track(rfs, &rtrack, fs->io);
+retry:
+=09init_resource_track(&rtrack, "allocate_new_itables", fs->io);
+=09allocate_new_itables(rfs);
+=09if (retval)
+=09=09goto errout;
+=09print_resource_track(rfs, &rtrack, fs->io);
+
+=09init_resource_track(&rtrack, "make_room_for_new_itables", fs->io);
+=09make_room_for_new_itables(rfs);
+=09if (retval)
+=09=09goto errout;
+=09print_resource_track(rfs, &rtrack, fs->io);
+
 =09init_resource_track(&rtrack, "blocks_to_move", fs->io);
 =09retval =3D blocks_to_move(rfs);
 =09if (retval)
@@ -195,12 +244,22 @@ errcode_t resize_fs(ext2_filsys fs, blk64_t *new_size=
, int flags,
 =09=09goto errout;
 =09print_resource_track(rfs, &rtrack, fs->io);
=20
+=09if ((rfs->flags & RESIZE_INCREASE_INODE_COUNT) &&
+=09    rfs->allocated_new_itables < rfs->new_fs->group_desc_count)
+=09=09goto retry;
+
 =09init_resource_track(&rtrack, "inode_ref_fix", fs->io);
 =09retval =3D inode_ref_fix(rfs);
 =09if (retval)
 =09=09goto errout;
 =09print_resource_track(rfs, &rtrack, fs->io);
=20
+=09init_resource_track(&rtrack, "move_inodes_to_smaller_tables", fs->io);
+=09move_inodes_to_smaller_tables(rfs);
+=09if (retval)
+=09=09goto errout;
+=09print_resource_track(rfs, &rtrack, fs->io);
+
 =09init_resource_track(&rtrack, "move_itables", fs->io);
 =09retval =3D move_itables(rfs);
 =09if (retval)
@@ -268,6 +327,11 @@ errout:
 =09}
 =09if (rfs->itable_buf)
 =09=09ext2fs_free_mem(&rfs->itable_buf);
+=09if (rfs->evacuated_inodes)
+=09=09ext2fs_free_mem(&rfs->evacuated_inodes);
+=09if (rfs->new_itable_status)
+=09=09ext2fs_free_mem(&rfs->new_itable_status);
+
 =09ext2fs_free_mem(&rfs);
 =09return retval;
 }
@@ -1130,6 +1194,9 @@ static errcode_t adjust_superblock(ext2_resize_t rfs,=
 blk64_t new_size)
 =09ext2fs_mark_bb_dirty(fs);
 =09ext2fs_mark_ib_dirty(fs);
=20
+=09if (rfs->flags & (RESIZE_INCREASE_INODE_COUNT | RESIZE_DECREASE_INODE_C=
OUNT))
+=09=09return 0;
+
 =09retval =3D ext2fs_allocate_block_bitmap(fs, _("reserved blocks"),
 =09=09=09=09=09      &rfs->reserve_blocks);
 =09if (retval)
@@ -1237,7 +1304,7 @@ errout:
  * This helper function creates a block bitmap with all of the
  * filesystem meta-data blocks.
  */
-static errcode_t mark_table_blocks(ext2_filsys fs,
+errcode_t mark_table_blocks(ext2_filsys fs,
 =09=09=09=09   ext2fs_block_bitmap bmap)
 {
 =09dgrp_t=09=09=09i;
@@ -1367,6 +1434,10 @@ static errcode_t blocks_to_move(ext2_resize_t rfs)
 =09ext2fs_block_bitmap=09meta_bmap, new_meta_bmap =3D NULL;
 =09int=09=09flex_bg;
=20
+=09if (rfs->flags
+=09=09& (RESIZE_INCREASE_INODE_COUNT | RESIZE_DECREASE_INODE_COUNT))
+=09=09return 0;
+
 =09fs =3D rfs->new_fs;
 =09old_fs =3D rfs->old_fs;
 =09if (ext2fs_blocks_count(old_fs->super) > ext2fs_blocks_count(fs->super)=
)
@@ -1748,18 +1819,40 @@ static errcode_t resize2fs_get_alloc_block(ext2_fil=
sys fs,
 =09=09       (unsigned long long) blk);
 #endif
=20
-=09ext2fs_mark_block_bitmap2(rfs->old_fs->block_map, blk);
-=09ext2fs_mark_block_bitmap2(rfs->new_fs->block_map, blk);
=20
-=09group =3D ext2fs_group_of_blk2(rfs->old_fs, blk);
-=09ext2fs_clear_block_uninit(rfs->old_fs, group);
-=09group =3D ext2fs_group_of_blk2(rfs->new_fs, blk);
-=09ext2fs_clear_block_uninit(rfs->new_fs, group);
+=09if (rfs->flags & RESIZE_INCREASE_INODE_COUNT) {
+=09=09if (fs =3D=3D rfs->new_fs) {
+=09=09=09ext2fs_block_alloc_stats2(rfs->old_fs, blk, +1);
+
+=09=09=09ext2fs_mark_block_bitmap2(rfs->new_fs->block_map, blk);
+=09=09=09group =3D ext2fs_group_of_blk2(rfs->new_fs, blk);
+=09=09=09ext2fs_clear_block_uninit(rfs->new_fs, group);
+=09=09} else {
+=09=09=09ext2fs_block_alloc_stats2(rfs->new_fs, blk, +1);
+
+=09=09=09ext2fs_mark_block_bitmap2(rfs->old_fs->block_map, blk);
+=09=09=09group =3D ext2fs_group_of_blk2(rfs->old_fs, blk);
+=09=09=09ext2fs_clear_block_uninit(rfs->old_fs, group);
+=09=09}
+=09} else {
+=09=09ext2fs_mark_block_bitmap2(rfs->old_fs->block_map, blk);
+=09=09ext2fs_mark_block_bitmap2(rfs->new_fs->block_map, blk);
+
+=09=09group =3D ext2fs_group_of_blk2(rfs->old_fs, blk);
+=09=09ext2fs_clear_block_uninit(rfs->old_fs, group);
+=09=09group =3D ext2fs_group_of_blk2(rfs->new_fs, blk);
+=09=09ext2fs_clear_block_uninit(rfs->new_fs, group);
+=09}
=20
 =09*ret =3D (blk64_t) blk;
 =09return 0;
 }
=20
+static inline ext2_filsys get_fs_of_ino(ext2_resize_t rfs, ext2_ino_t ino)=
 {
+=09return (rfs->new_itable_status[ext2fs_group_of_ino(rfs->new_fs, ino)]
+=09=09=3D=3D itable_status_populated) ? rfs->new_fs : rfs->old_fs;
+}
+
 static errcode_t block_mover(ext2_resize_t rfs)
 {
 =09blk64_t=09=09=09blk, old_blk, new_blk;
@@ -1770,11 +1863,18 @@ static errcode_t block_mover(ext2_resize_t rfs)
 =09int=09=09=09to_move, moved;
 =09ext2_badblocks_list=09badblock_list =3D 0;
 =09int=09=09=09bb_modified =3D 0;
+=09ext2_filsys             fs_bb_inode =3D old_fs;
+
+=09if (rfs->flags & RESIZE_DECREASE_INODE_COUNT)
+=09        return 0;
=20
 =09fs->get_alloc_block =3D resize2fs_get_alloc_block;
 =09old_fs->get_alloc_block =3D resize2fs_get_alloc_block;
=20
-=09retval =3D ext2fs_read_bb_inode(old_fs, &badblock_list);
+=09if (rfs->flags & RESIZE_INCREASE_INODE_COUNT)
+=09=09fs_bb_inode =3D get_fs_of_ino(rfs, EXT2_BAD_INO);
+
+=09retval =3D ext2fs_read_bb_inode(fs_bb_inode, &badblock_list);
 =09if (retval)
 =09=09return retval;
=20
@@ -1810,9 +1910,15 @@ static errcode_t block_mover(ext2_resize_t rfs)
 =09=09}
=20
 =09=09new_blk =3D get_new_block(rfs);
-=09=09if (!new_blk) {
-=09=09=09retval =3D ENOSPC;
-=09=09=09goto errout;
+=09=09if (rfs->flags & RESIZE_INCREASE_INODE_COUNT) {
+=09=09=09if (!new_blk)
+=09=09=09=09break;
+=09=09=09ext2fs_block_alloc_stats2(old_fs, new_blk, +1);
+=09=09} else {
+=09=09=09if (!new_blk) {
+=09=09=09=09retval =3D ENOSPC;
+=09=09=09=09goto errout;
+=09=09=09}
 =09=09}
 =09=09ext2fs_block_alloc_stats2(fs, new_blk, +1);
 =09=09ext2fs_add_extent_entry(rfs->bmap, B2C(blk), B2C(new_blk));
@@ -1865,6 +1971,13 @@ static errcode_t block_mover(ext2_resize_t rfs)
 =09=09=09retval =3D io_channel_write_blk64(fs->io, new_blk, c,
 =09=09=09=09=09=09=09rfs->itable_buf);
 =09=09=09if (retval) goto errout;
+
+=09=09=09if (rfs->flags & RESIZE_INCREASE_INODE_COUNT) {
+=09=09=09=09ext2fs_block_alloc_stats_range(fs, old_blk,
+=09=09=09=09=09=09=09=09c, -1);
+=09=09=09=09ext2fs_block_alloc_stats_range(old_fs, old_blk,
+=09=09=09=09=09=09=09=09c, -1);
+=09=09=09}
 =09=09=09size -=3D c;
 =09=09=09new_blk +=3D c;
 =09=09=09old_blk +=3D c;
@@ -1884,7 +1997,7 @@ static errcode_t block_mover(ext2_resize_t rfs)
 errout:
 =09if (badblock_list) {
 =09=09if (!retval && bb_modified)
-=09=09=09retval =3D ext2fs_update_bb_inode(old_fs,
+=09=09=09retval =3D ext2fs_update_bb_inode(fs_bb_inode,
 =09=09=09=09=09=09=09badblock_list);
 =09=09ext2fs_badblocks_list_free(badblock_list);
 =09}
@@ -1954,7 +2067,7 @@ static int process_block(ext2_filsys fs, blk64_t=09*b=
lock_nr,
 =09=09}
 =09}
=20
-=09if (pb->is_dir) {
+=09if (pb->is_dir && !(pb->rfs->flags & RESIZE_INCREASE_INODE_COUNT)) {
 =09=09retval =3D ext2fs_add_dir_block2(fs->dblist, pb->ino,
 =09=09=09=09=09       block, (int) blockcnt);
 =09=09if (retval) {
@@ -1993,35 +2106,35 @@ static errcode_t progress_callback(ext2_filsys fs,
 =09return 0;
 }
=20
-static errcode_t migrate_ea_block(ext2_resize_t rfs, ext2_ino_t ino,
-=09=09=09=09  struct ext2_inode *inode, int *changed)
+static errcode_t migrate_ea_block(ext2_extent bmap, ext2_filsys fs,
+=09=09=09ext2_ino_t ino, struct ext2_inode *inode, int *changed)
 {
 =09char *buf =3D NULL;
 =09blk64_t new_block;
 =09errcode_t err =3D 0;
=20
 =09/* No EA block or no remapping?  Quit early. */
-=09if (ext2fs_file_acl_block(rfs->old_fs, inode) =3D=3D 0 || !rfs->bmap)
+=09if (ext2fs_file_acl_block(fs, inode) =3D=3D 0 || !bmap)
 =09=09return 0;
-=09new_block =3D extent_translate(rfs->old_fs, rfs->bmap,
-=09=09ext2fs_file_acl_block(rfs->old_fs, inode));
+=09new_block =3D extent_translate(fs, bmap,
+=09=09ext2fs_file_acl_block(fs, inode));
 =09if (new_block =3D=3D 0)
 =09=09return 0;
=20
 =09/* Set the new ACL block */
-=09ext2fs_file_acl_block_set(rfs->old_fs, inode, new_block);
+=09ext2fs_file_acl_block_set(fs, inode, new_block);
=20
 =09/* Update checksum */
-=09if (ext2fs_has_feature_metadata_csum(rfs->new_fs->super)) {
-=09=09err =3D ext2fs_get_mem(rfs->old_fs->blocksize, &buf);
+=09if (ext2fs_has_feature_metadata_csum(fs->super)) {
+=09=09err =3D ext2fs_get_mem(fs->blocksize, &buf);
 =09=09if (err)
 =09=09=09return err;
-=09=09rfs->old_fs->flags |=3D EXT2_FLAG_IGNORE_CSUM_ERRORS;
-=09=09err =3D ext2fs_read_ext_attr3(rfs->old_fs, new_block, buf, ino);
-=09=09rfs->old_fs->flags &=3D ~EXT2_FLAG_IGNORE_CSUM_ERRORS;
+=09=09fs->flags |=3D EXT2_FLAG_IGNORE_CSUM_ERRORS;
+=09=09err =3D ext2fs_read_ext_attr3(fs, new_block, buf, ino);
+=09=09fs->flags &=3D ~EXT2_FLAG_IGNORE_CSUM_ERRORS;
 =09=09if (err)
 =09=09=09goto out;
-=09=09err =3D ext2fs_write_ext_attr3(rfs->old_fs, new_block, buf, ino);
+=09=09err =3D ext2fs_write_ext_attr3(fs, new_block, buf, ino);
 =09=09if (err)
 =09=09=09goto out;
 =09}
@@ -2184,30 +2297,34 @@ static errcode_t inode_scan_and_fix(ext2_resize_t r=
fs)
 =09struct process_block_struct=09pb;
 =09ext2_ino_t=09=09ino, new_inode;
 =09struct ext2_inode =09*inode =3D NULL;
-=09ext2_inode_scan =09scan =3D NULL;
 =09errcode_t=09=09retval;
 =09char=09=09=09*block_buf =3D 0;
 =09ext2_ino_t=09=09start_to_move;
 =09int=09=09=09inode_size;
 =09int=09=09=09update_ea_inode_refs =3D 0;
+=09ext2_filsys=09=09fs =3D rfs->old_fs;
=20
 =09if ((rfs->old_fs->group_desc_count <=3D
 =09     rfs->new_fs->group_desc_count) &&
-=09    !rfs->bmap)
+=09    !rfs->bmap &&
+=09    !(rfs->flags & RESIZE_DECREASE_INODE_COUNT))
 =09=09return 0;
=20
 =09set_com_err_hook(quiet_com_err_proc);
=20
-=09retval =3D ext2fs_open_inode_scan(rfs->old_fs, 0, &scan);
-=09if (retval) goto errout;
-
 =09retval =3D ext2fs_init_dblist(rfs->old_fs, 0);
 =09if (retval) goto errout;
 =09retval =3D ext2fs_get_array(rfs->old_fs->blocksize, 3, &block_buf);
 =09if (retval) goto errout;
=20
-=09start_to_move =3D (rfs->new_fs->group_desc_count *
-=09=09=09 rfs->new_fs->super->s_inodes_per_group);
+=09/*the new_fs is not yet updated with the new_inodes_per_group*/
+=09if (rfs->flags & RESIZE_DECREASE_INODE_COUNT)
+=09      start_to_move =3D (rfs->new_fs->group_desc_count *
+                         rfs->new_inodes_per_group);
+        else
+              start_to_move =3D (rfs->new_fs->group_desc_count *
+                         rfs->new_fs->super->s_inodes_per_group);
+
=20
 =09if (rfs->progress) {
 =09=09retval =3D (rfs->progress)(rfs, E2_RSZ_INODE_SCAN_PASS,
@@ -2215,7 +2332,6 @@ static errcode_t inode_scan_and_fix(ext2_resize_t rfs=
)
 =09=09if (retval)
 =09=09=09goto errout;
 =09}
-=09ext2fs_set_inode_callback(scan, progress_callback, (void *) rfs);
 =09pb.rfs =3D rfs;
 =09pb.inode =3D inode;
 =09pb.error =3D 0;
@@ -2226,16 +2342,26 @@ static errcode_t inode_scan_and_fix(ext2_resize_t r=
fs)
 =09=09retval =3D ENOMEM;
 =09=09goto errout;
 =09}
+
 =09/*
 =09 * First, copy all of the inodes that need to be moved
 =09 * elsewhere in the inode table
 =09 */
-=09while (1) {
-=09=09retval =3D ext2fs_get_next_inode_full(scan, &ino, inode, inode_size)=
;
-=09=09if (retval) goto errout;
+=09for (ino =3D 1; ino <=3D rfs->old_fs->super->s_inodes_count; ino++) {
 =09=09if (!ino)
 =09=09=09break;
=20
+=09=09if (rfs->flags & RESIZE_INCREASE_INODE_COUNT)
+=09=09=09fs =3D get_fs_of_ino(rfs, ino);
+
+=09=09retval =3D ext2fs_read_inode2(fs, ino, inode, inode_size,
+=09=09=09=09=09=09=09READ_INODE_NOCSUM);
+=09=09if (retval) goto errout;
+=09=09if (ino > 1 && ext2fs_group_of_ino(rfs->old_fs, ino)
+=09=09=09!=3D ext2fs_group_of_ino(rfs->old_fs, ino-1))
+=09=09=09      progress_callback(rfs->old_fs, NULL,
+=09=09=09=09ext2fs_group_of_ino(rfs->old_fs, ino-1), rfs);
+
 =09=09if (inode->i_links_count =3D=3D 0 && ino !=3D EXT2_RESIZE_INO)
 =09=09=09continue; /* inode not in use */
=20
@@ -2243,7 +2369,7 @@ static errcode_t inode_scan_and_fix(ext2_resize_t rfs=
)
 =09=09pb.changed =3D 0;
=20
 =09=09/* Remap EA block */
-=09=09retval =3D migrate_ea_block(rfs, ino, inode, &pb.changed);
+=09=09retval =3D migrate_ea_block(rfs->bmap, fs, ino, inode, &pb.changed);
 =09=09if (retval)
 =09=09=09goto errout;
=20
@@ -2291,7 +2417,7 @@ static errcode_t inode_scan_and_fix(ext2_resize_t rfs=
)
=20
 remap_blocks:
 =09=09if (pb.changed)
-=09=09=09retval =3D ext2fs_write_inode_full(rfs->old_fs,
+=09=09=09retval =3D ext2fs_write_inode_full(fs,
 =09=09=09=09=09=09=09 new_inode,
 =09=09=09=09=09=09=09 inode, inode_size);
 =09=09if (retval)
@@ -2302,13 +2428,13 @@ remap_blocks:
 =09=09 * blocks for inode remapping.  Need to write out dir blocks
 =09=09 * with new inode numbers if we have metadata_csum enabled.
 =09=09 */
-=09=09rfs->old_fs->flags |=3D EXT2_FLAG_IGNORE_CSUM_ERRORS;
-=09=09if (ext2fs_inode_has_valid_blocks2(rfs->old_fs, inode) &&
+=09=09fs->flags |=3D EXT2_FLAG_IGNORE_CSUM_ERRORS;
+=09=09if (ext2fs_inode_has_valid_blocks2(fs, inode) &&
 =09=09    (rfs->bmap || pb.is_dir)) {
 =09=09=09pb.ino =3D new_inode;
 =09=09=09pb.old_ino =3D ino;
 =09=09=09pb.has_extents =3D inode->i_flags & EXT4_EXTENTS_FL;
-=09=09=09retval =3D ext2fs_block_iterate3(rfs->old_fs,
+=09=09=09retval =3D ext2fs_block_iterate3(fs,
 =09=09=09=09=09=09       new_inode, 0, block_buf,
 =09=09=09=09=09=09       process_block, &pb);
 =09=09=09if (retval)
@@ -2328,7 +2454,8 @@ remap_blocks:
=20
 =09=09/* Fix up extent block checksums with the new inode number */
 =09=09if (ext2fs_has_feature_metadata_csum(rfs->old_fs->super) &&
-=09=09    (inode->i_flags & EXT4_EXTENTS_FL)) {
+=09=09    (inode->i_flags & EXT4_EXTENTS_FL) &&
+=09=09    !(rfs->flags & RESIZE_INCREASE_INODE_COUNT)) {
 =09=09=09retval =3D ext2fs_fix_extents_checksums(rfs->old_fs,
 =09=09=09=09=09=09=09      new_inode, NULL);
 =09=09=09if (retval)
@@ -2344,16 +2471,16 @@ remap_blocks:
 =09=09=09goto errout;
 =09}
 =09io_channel_flush(rfs->old_fs->io);
+=09progress_callback(rfs->old_fs, NULL, fs->group_desc_count-1, rfs);
=20
 errout:
 =09reset_com_err_hook();
 =09rfs->old_fs->flags &=3D ~EXT2_FLAG_IGNORE_CSUM_ERRORS;
+=09rfs->new_fs->flags &=3D ~EXT2_FLAG_IGNORE_CSUM_ERRORS;
 =09if (rfs->bmap) {
 =09=09ext2fs_free_extent_table(rfs->bmap);
 =09=09rfs->bmap =3D 0;
 =09}
-=09if (scan)
-=09=09ext2fs_close_inode_scan(scan);
 =09if (block_buf)
 =09=09ext2fs_free_mem(&block_buf);
 =09free(inode);
@@ -2438,7 +2565,7 @@ static errcode_t inode_ref_fix(ext2_resize_t rfs)
 =09errcode_t=09=09retval;
 =09struct istruct =09=09is;
=20
-=09if (!rfs->imap)
+=09if (!rfs->imap || rfs->flags & RESIZE_INCREASE_INODE_COUNT)
 =09=09return 0;
=20
 =09/*
@@ -2513,6 +2640,10 @@ static errcode_t move_itables(ext2_resize_t rfs)
 =09unsigned int=09j;
 =09ext2fs_block_bitmap=09new_bmap =3D NULL;
=20
+=09if (rfs->flags
+=09    & (RESIZE_INCREASE_INODE_COUNT | RESIZE_DECREASE_INODE_COUNT))
+=09=09return 0;
+
 =09max_groups =3D fs->group_desc_count;
 =09if (max_groups > rfs->old_fs->group_desc_count)
 =09=09max_groups =3D rfs->old_fs->group_desc_count;
@@ -3321,3 +3452,727 @@ blk64_t calculate_minimum_resize_size(ext2_filsys f=
s, int flags)
=20
 =09return blks_needed;
 }
+
+/*
+ * The function ext2fs_block_alloc_stats_range() doesn't expect to
+ * receive unaligned blocks or uneven lengths, which may be the case
+ * with itables for bigalloc filesystems. This function will modify the in=
put
+ * values to compensate for those issues before calling
+ * ext2fs_block_alloc_stats_range(). We assume any other metadata (blockma=
ps,
+ * inodemaps, etc...) is always placed before inode tables if they share t=
he
+ * same cluster (which is how mkfs creates the filesystems), so we avoid t=
o
+ * free the cluster if the inode table doesn't own its first block
+ */
+static void tweak_values_for_bigalloc(ext2_resize_t rfs,
+=09=09=09blk64_t *first_block, unsigned int *num_blocks)
+{
+=09blk64_t start, end, diff,
+=09=09cluster_size =3D EXT2FS_CLUSTER_RATIO(rfs->new_fs);
+
+=09start =3D *first_block;
+=09end =3D *first_block + *num_blocks - 1;
+
+=09/*If the first block to free is not aligned with the
+=09   beginning of the cluster, we will move it to the
+=09   beginning of the next cluster. */
+=09if (start % cluster_size) {
+=09=09diff =3D cluster_size - (start % cluster_size);
+=09=09*first_block +=3D diff;
+
+=09=09/*overflow case if we are freeing very few blocks */
+=09=09if (*num_blocks <=3D diff)
+=09=09=09*num_blocks =3D 0;
+=09=09else
+=09=09=09*num_blocks -=3D diff;
+=09}
+
+=09/*If the end block is not aligned with the end of
+=09   the cluster, we will move it to the end of
+=09   the current cluster. */
+=09if (!
+=09    ((end & EXT2FS_CLUSTER_MASK(rfs->new_fs)) =3D=3D
+=09     EXT2FS_CLUSTER_MASK(rfs->new_fs)) && *num_blocks !=3D 0)
+=09=09*num_blocks +=3D cluster_size - (end % cluster_size) - 1;
+
+=09/*If we have many itables in the same cluster (aka.: very
+=09   small num_blocks), the responsible to free the cluster will
+=09   be the call having the first block of the cluster. The other
+=09   calls shall not attempt to free it to avoid duplicated frees */
+=09if (*first_block > (end & ~EXT2FS_CLUSTER_MASK(rfs->new_fs))) {
+=09=09if (*num_blocks <=3D cluster_size)
+=09=09=09*num_blocks =3D 0;
+=09=09else
+=09=09=09*num_blocks -=3D cluster_size;
+=09}
+}
+
+
+/*
+ * This function will free the unused space of inode tables after
+ * reducing the inode count. For fs with the flex_bg feature set, if
+ * the inodes tables were contiguous for several groups, it will also
+ * move the blocks to keep the inode tables contiguous
+ */
+static errcode_t reubicate_and_free_itables(ext2_resize_t rfs)
+{
+=09errcode_t retval =3D 0;
+=09dgrp_t group;
+=09unsigned int len;
+=09blk64_t after_prev_itable;
+
+=09if (!rfs->itable_buf) {
+=09=09retval =3D ext2fs_get_array(rfs->new_fs->blocksize,
+=09=09=09=09     rfs->new_fs->inode_blocks_per_group,
+=09=09=09=09     &rfs->itable_buf);
+=09=09if (retval)
+=09=09=09goto errout;
+
+=09=09memset(rfs->itable_buf, 0,
+=09=09       rfs->new_fs->blocksize *
+=09=09       rfs->new_fs->inode_blocks_per_group);
+=09}
+
+        after_prev_itable =3D ext2fs_inode_table_loc(rfs->old_fs, 0) +
+=09=09    rfs->new_fs->inode_blocks_per_group;
+
+=09for (group =3D 1; group < rfs->new_fs->group_desc_count; group++) {
+
+=09=09if (ext2fs_has_feature_flex_bg(rfs->new_fs->super)
+=09=09      && ext2fs_inode_table_loc(rfs->old_fs, group - 1) +
+=09=09=09rfs->old_fs->inode_blocks_per_group =3D=3D
+=09=09=09ext2fs_inode_table_loc(rfs->old_fs, group)) {
+#ifdef RESIZE2FS_DEBUG
+=09=09=09if (rfs->flags & RESIZE_DEBUG_INODECOUNT)
+=09=09=09=09printf("moving itables, contiguous groups "
+=09=09=09=09=09"%u, %u, itables in %llu, %llu\n",
+=09=09=09=09=09     group - 1, group,
+=09=09=09=09     ext2fs_inode_table_loc(rfs->old_fs, group - 1),
+=09=09=09=09     ext2fs_inode_table_loc(rfs->old_fs, group));
+#endif
+=09=09=09retval =3D io_channel_read_blk64(rfs->old_fs->io,
+=09=09=09=09=09ext2fs_inode_table_loc(rfs->old_fs, group),
+=09=09=09=09=09rfs->new_fs->inode_blocks_per_group,
+=09=09=09=09=09rfs->itable_buf);
+=09=09=09if (retval)
+=09=09=09=09goto errout;
+=09=09=09retval =3D io_channel_write_blk64(rfs->old_fs->io,
+=09=09=09=09=09after_prev_itable,
+=09=09=09=09=09rfs->new_fs->inode_blocks_per_group,
+=09=09=09=09=09rfs->itable_buf);
+=09=09=09if (retval)
+=09=09=09=09goto errout;
+
+=09=09=09ext2fs_inode_table_loc_set(rfs->new_fs, group, after_prev_itable)=
;
+=09=09=09ext2fs_group_desc_csum_set(rfs->new_fs, group);
+=09=09=09after_prev_itable +=3D rfs->new_fs->inode_blocks_per_group;
+
+=09=09} else {
+=09=09=09len =3D  ext2fs_inode_table_loc(rfs->old_fs, group - 1) +
+=09=09=09=09    rfs->old_fs->inode_blocks_per_group -
+=09=09=09=09    after_prev_itable;
+=09=09=09if (ext2fs_has_feature_bigalloc(rfs->new_fs->super))
+=09=09=09=09tweak_values_for_bigalloc(rfs,
+=09=09=09=09=09=09=09  &after_prev_itable,
+=09=09=09=09=09=09=09  &len);
+=09=09=09ext2fs_block_alloc_stats_range(rfs->new_fs,
+=09=09=09=09=09=09       after_prev_itable,
+=09=09=09=09=09=09       len, -1);
+#ifdef RESIZE2FS_DEBUG
+=09=09=09if (rfs->flags & RESIZE_DEBUG_INODECOUNT)
+=09=09=09=09printf("unmarking %u blocks "
+=09=09=09=09=09"starting on block %llu\n",
+=09=09=09=09=09len, after_prev_itable);
+#endif
+
+=09=09=09after_prev_itable =3D ext2fs_inode_table_loc(rfs->old_fs, group) =
+
+=09=09=09=09=09    rfs->new_fs->inode_blocks_per_group;
+=09=09}
+=09}
+
+=09len =3D ext2fs_inode_table_loc(rfs->old_fs,  group - 1) +
+=09=09    rfs->old_fs->inode_blocks_per_group - after_prev_itable;
+=09if (ext2fs_has_feature_bigalloc(rfs->new_fs->super))
+=09=09tweak_values_for_bigalloc(rfs, &after_prev_itable, &len);
+=09ext2fs_block_alloc_stats_range(rfs->new_fs, after_prev_itable,
+=09=09=09=09       len, -1);
+#ifdef RESIZE2FS_DEBUG
+=09if (rfs->flags & RESIZE_DEBUG_INODECOUNT)
+=09=09printf("unmarking %u blocks starting on block %llu\n",
+=09=09     len, after_prev_itable);
+#endif
+
+ errout:
+=09if (rfs->itable_buf)
+=09=09ext2fs_free_mem(&rfs->itable_buf);
+=09return retval;
+}
+
+/*************************************************************************=
*****
+We will migrate the inodes in-place to the existing tables. We do not allo=
cate
+new itables when reducing the inode count. The advantage of this approach =
is
+that we don't need any free blocks in the filesystem for this operation. I=
t
+could be done in a fs with zero free blocks, which might also be the reaso=
n to
+run the reducer: free some space for data. What follow is a simple proof t=
hat
+there is no risk of overwriting an inode before needing to read it.
+
+Let:
+g: block group, 0-based
+ipg: inodes per group
+pos: inode position within the inode table of the block group, 1-based
+inum: inode number
+
+This gives the inode number formula:
+inum =3D g * ipg + pos
+
+When reducing the inode count, we start from the highest inode number
+and go down to 1.
+
+This operation shall not overwrite a needed inode before it is migrated:
+To overwrite a needed inode in a given g & pos before being migrated, its
+inum_old shall be less than its inum_new, as the migration loop is
+moving backwards. So:
+
+inum_old < inum_new
+
+Substitute. As we talk about the same memory position, g & pos are the sam=
e,
+only ipg changes:
+
+g * ipg_old + pos < g * ipg_new + pos
+
+Thus, an overwrite will require ipg_olg < ipg_new.
+However, we are reducing the inode count, so we are doing ipg_old > ipg_ne=
w.
+Therefore, the migration loop will not overwrite needed inodes before
+migrating them.
+**************************************************************************=
****/
+static errcode_t migrate_inodes_backwards_loop(ext2_resize_t rfs)
+{
+=09ext2_ino_t ino;
+=09struct ext2_inode *inode =3D NULL;
+=09errcode_t retval;
+=09int inode_size =3D EXT2_INODE_SIZE(rfs->new_fs->super);
+
+=09inode =3D malloc(inode_size);
+=09if (!inode) {
+=09=09retval =3D ENOMEM;
+=09=09goto errout;
+=09}
+
+=09for (ino =3D rfs->new_fs->super->s_inodes_count; ino > 0; ino--) {
+
+=09=09retval =3D ext2fs_read_inode2(rfs->old_fs, ino, inode, inode_size, 0=
);
+#ifdef RESIZE2FS_DEBUG
+=09=09if (rfs->flags & RESIZE_DEBUG_INODECOUNT)
+=09=09=09printf("Migrating inode %u to new position: old group: "
+=09=09=09=09"%u, new group: %u, read_retval: %li", ino,
+=09=09=09=09ext2fs_group_of_ino(rfs->old_fs, ino),
+=09=09=09=09ext2fs_group_of_ino(rfs->new_fs, ino), retval);
+#endif
+=09=09/*we require to run fsck before changing the inode count,
+=09=09and that will fix inode checksums on used inodes. However,
+=09=09an unused inode with a wrong checksum will not be detected
+=09=09by fsck. We don't want to stop the whole process now and
+=09=09leave a messy fs because of that, just log it and continue */
+=09=09if (retval && retval !=3D EXT2_ET_INODE_CSUM_INVALID)
+=09=09=09goto errout;
+
+=09=09if (inode->i_links_count !=3D 0
+=09=09    || ino < EXT2_FIRST_INODE(rfs->new_fs->super)) {
+=09=09=09ext2fs_inode_alloc_stats2(rfs->new_fs, ino, +1,
+=09=09=09=09=09=09  LINUX_S_ISDIR(inode->i_mode));
+=09=09}
+
+=09=09/*if not in use, write the zeros from the inode to the itable
+=09=09anyway, to overwrite any previous inode */
+=09=09retval =3D ext2fs_write_inode2(rfs->new_fs, ino, inode, inode_size, =
0);
+#ifdef RESIZE2FS_DEBUG
+=09=09if (rfs->flags & RESIZE_DEBUG_INODECOUNT)
+=09=09=09printf(", write_retval: %li\n", retval);
+#endif
+=09=09if (retval)
+=09=09=09goto errout;
+
+=09}
+
+ errout:
+=09if (inode)
+=09=09free(inode);
+
+=09return retval;
+}
+
+static void update_inode_info_in_fs(ext2_resize_t rfs) {
+=09dgrp_t g;
+=09ext2_filsys fs =3D rfs->new_fs;
+
+=09fs->super->s_inodes_per_group =3D rfs->new_inodes_per_group;
+=09fs->inode_blocks_per_group =3D
+=09    ext2fs_div_ceil(fs->super->s_inodes_per_group *
+=09=09=09    fs->super->s_inode_size,
+=09=09=09    fs->blocksize);
+=09fs->super->s_inodes_count =3D
+=09    fs->group_desc_count * fs->super->s_inodes_per_group;
+=09fs->super->s_free_inodes_count =3D fs->super->s_inodes_count;
+
+=09for (g =3D 0; g < fs->group_desc_count; g++) {
+=09=09ext2fs_bg_used_dirs_count_set(fs, g, 0);
+=09=09ext2fs_bg_free_inodes_count_set(fs, g,
+=09=09=09=09    fs->super->s_inodes_per_group);
+=09=09if (ext2fs_has_group_desc_csum(fs))
+=09=09=09ext2fs_bg_itable_unused_set(fs, g,
+=09=09=09=09    fs->super->s_inodes_per_group);
+=09}
+
+}
+
+
+/*At this point all inodes above the new s_inodes_count have been
+relocated to smaller numbers. Now, we just need to move them to
+their new inode table positions*/
+static errcode_t move_inodes_to_smaller_tables(ext2_resize_t rfs)
+{
+=09errcode_t retval;
+
+=09if (!(rfs->flags & RESIZE_DECREASE_INODE_COUNT))
+=09=09return 0;
+
+=09io_channel_flush(rfs->old_fs->io);
+
+=09update_inode_info_in_fs(rfs);
+
+=09retval =3D migrate_inodes_backwards_loop(rfs);
+=09if (retval)
+=09=09goto errout;
+
+=09retval =3D reubicate_and_free_itables(rfs);
+=09if (retval)
+=09=09goto errout;
+
+=09ext2fs_mark_super_dirty(rfs->new_fs);
+=09io_channel_flush(rfs->new_fs->io);
+
+ errout:
+
+=09return retval;
+}
+
+
+/*initialize the data structures needed to increase the inode count*/
+static errcode_t init_increase_inode_count(ext2_resize_t rfs)
+{
+=09errcode_t retval;
+
+=09if (!(rfs->flags & RESIZE_INCREASE_INODE_COUNT))
+=09=09return 0;
+
+=09retval =3D ext2fs_get_memzero(rfs->new_fs->group_desc_count *
+=09=09=09sizeof(unsigned int), &rfs->evacuated_inodes);
+=09if (retval)
+=09=09goto errout;
+
+=09retval =3D ext2fs_get_memzero(rfs->new_fs->group_desc_count *
+=09=09=09sizeof(itable_status), &rfs->new_itable_status);
+=09if (retval)
+=09=09goto errout;
+
+/*avoid early stop if the first iteration doesn't allocate any new inode t=
able*/
+#define ALLOCATED_NEW_ITABLE_FIRST_ITERATION 0xFFFFFFFF
+=09rfs->allocated_new_itables =3D ALLOCATED_NEW_ITABLE_FIRST_ITERATION;
+
+=09update_inode_info_in_fs(rfs);
+
+=09retval =3D
+=09    ext2fs_resize_inode_bitmap2(rfs->new_fs->super->s_inodes_count,
+=09=09=09=09=09rfs->new_fs->super->s_inodes_count,
+=09=09=09=09=09rfs->new_fs->inode_map);
+=09if (retval) {
+=09=09fprintf(stderr, "error %li when calling "
+=09=09=09"ext2fs_resize_inode_bitmap2()\n", retval);
+=09=09goto errout;
+=09}
+
+ errout:
+=09return retval;
+}
+
+/*
+ * For a bigalloc filesystem, we may have a cluster whose blocks are used
+ * for different purposes: some are used for blockmaps/inodemaps and other=
s
+ * are used for inode tables. This function will fix group stats
+ */
+static void fix_itables_stats_bigalloc(ext2_filsys fs, blk64_t start,
+=09=09=09=09=09    unsigned int len)
+{
+=09blk64_t blk, rem, cluster_size;
+=09dgrp_t group_of_block;
+
+=09cluster_size =3D EXT2FS_CLUSTER_RATIO(fs);
+
+=09/*we assume start of the new itable given by the
+=09ext2fs_allocate_group_table function is aligned
+=09with start of the cluster, we only do the fix for
+=09end of itable */
+=09blk =3D start + len - 1;
+=09group_of_block =3D ext2fs_group_of_blk2(fs, blk);
+
+=09rem =3D (blk + 1) % cluster_size;
+=09if (rem) {
+=09=09ext2fs_bg_free_blocks_count_set(fs, group_of_block,
+=09=09=09ext2fs_bg_free_blocks_count(fs, group_of_block)=09- 1);
+=09=09ext2fs_bg_flags_clear(fs, group_of_block, EXT2_BG_BLOCK_UNINIT);
+=09=09ext2fs_group_desc_csum_set(fs, group_of_block);
+=09=09ext2fs_free_blocks_count_add(fs->super, -(cluster_size - rem));
+=09=09ext2fs_mark_super_dirty(fs);
+=09=09ext2fs_mark_bb_dirty(fs);
+=09}
+}
+
+
+/*
+ * This function will migrate inodes to the new inode tables
+ * when increasing the inode count
+ */
+static errcode_t migrate_inodes_forward_loop(ext2_resize_t rfs)
+{
+=09ext2_ino_t ino_num;
+=09struct ext2_inode *inode =3D NULL;
+=09int inode_size =3D EXT2_INODE_SIZE(rfs->new_fs->super);
+=09dgrp_t group, new_group, old_group;
+=09errcode_t retval =3D 0;
+=09blk64_t itable_start;
+=09unsigned int len;
+
+=09inode =3D malloc(inode_size);
+=09if (!inode) {
+=09=09retval =3D ENOMEM;
+=09=09goto errout;
+=09}
+
+=09for (ino_num =3D 1; ino_num <=3D rfs->old_fs->super->s_inodes_count;
+=09     ino_num++) {
+=09=09if (!ino_num)
+=09=09=09break;
+
+=09=09new_group =3D ext2fs_group_of_ino(rfs->new_fs, ino_num);
+=09=09old_group =3D ext2fs_group_of_ino(rfs->old_fs, ino_num);
+=09=09if (rfs->new_itable_status[new_group] !=3D
+=09=09    itable_status_allocated) {
+=09=09=09if (new_group =3D=3D rfs->new_fs->group_desc_count - 1)
+=09=09=09=09break;=09/*no more groups? break loop */
+=09=09=09ino_num =3D (new_group + 1)
+=09=09=09    * rfs->new_fs->super->s_inodes_per_group;
+=09=09=09continue;
+=09=09}
+
+=09=09retval =3D ext2fs_read_inode2(rfs->old_fs, ino_num,
+=09=09=09=09=09=09inode, inode_size, 0);
+#ifdef RESIZE2FS_DEBUG
+=09=09if (rfs->flags & RESIZE_DEBUG_INODECOUNT)
+=09=09=09printf("Migrating inode %u to new position: "
+=09=09=09"old group: %u, new group: %u, read_retval: %li",
+=09=09=09     ino_num, old_group, new_group, retval);
+#endif
+=09=09/*we require to run fsck before changing the inode count,
+=09=09and that will fix inode checksums on used inodes. However,
+=09=09an unused inode with a wrong checksum will not be detected
+=09=09by fsck. We don't want to stop the whole process now and
+=09=09leave a messy fs because of that, just log it and continue */
+=09=09if (retval && retval !=3D EXT2_ET_INODE_CSUM_INVALID)
+=09=09=09goto errout;
+
+=09=09(rfs->evacuated_inodes[old_group])++;
+
+=09=09if (inode->i_links_count !=3D 0
+=09=09    || ino_num < EXT2_FIRST_INODE(rfs->new_fs->super)) {
+=09=09=09ext2fs_inode_alloc_stats2(rfs->new_fs, ino_num, +1,
+=09=09=09=09=09=09  LINUX_S_ISDIR(inode->i_mode));
+=09=09}
+
+=09=09retval =3D  ext2fs_write_inode2(rfs->new_fs, ino_num,
+=09=09=09=09=09=09inode, inode_size, 0);
+#ifdef RESIZE2FS_DEBUG
+=09=09if (rfs->flags & RESIZE_DEBUG_INODECOUNT)
+=09=09=09printf(", write_retval: %li\n", retval);
+#endif
+=09=09if (retval)
+=09=09=09goto errout;
+
+=09=09/*are we about to completely migrate this inode table? */
+=09=09if (ino_num =3D=3D rfs->old_fs->super->s_inodes_count ||
+=09=09=09ext2fs_group_of_ino(rfs->new_fs, ino_num + 1) !=3D new_group) {
+=09=09=09rfs->new_itable_status[new_group] =3D itable_status_populated;
+=09=09}
+=09}
+
+=09for (group =3D 0; group < rfs->new_fs->group_desc_count; group++) {
+=09=09itable_start =3D ext2fs_inode_table_loc(rfs->old_fs, group);
+=09=09if (itable_start !=3D 0
+=09=09    && rfs->evacuated_inodes[group] =3D=3D
+=09=09    rfs->old_fs->super->s_inodes_per_group) {
+=09=09=09len =3D rfs->old_fs->inode_blocks_per_group;
+=09=09=09if (ext2fs_has_feature_bigalloc(rfs->new_fs->super)) {
+=09=09=09=09tweak_values_for_bigalloc(rfs, &itable_start,
+=09=09=09=09=09=09=09  &len);
+=09=09=09}
+
+=09=09=09ext2fs_block_alloc_stats_range(rfs->old_fs,
+=09=09=09=09=09=09       itable_start,
+=09=09=09=09=09=09       len, -1);
+=09=09=09ext2fs_block_alloc_stats_range(rfs->new_fs,
+=09=09=09=09=09=09       itable_start,
+=09=09=09=09=09=09       len, -1);
+=09=09=09ext2fs_inode_table_loc_set(rfs->old_fs, group, 0);
+=09=09}
+=09}
+
+ errout:
+=09if (inode)
+=09=09free(inode);
+=09return retval;
+}
+
+
+/*
+ * This function will allocate new inode tables
+ * when increasing the inode count
+ */
+static errcode_t allocate_new_itables(ext2_resize_t rfs)
+{
+=09blk64_t itable_start;
+=09errcode_t retval =3D 0;
+=09dgrp_t group =3D 0;
+=09int len =3D 0;
+=09dgrp_t prev_allocated_new_itables =3D rfs->allocated_new_itables;
+
+=09if (!(rfs->flags & RESIZE_INCREASE_INODE_COUNT))
+=09=09return 0;
+
+=09if (rfs->allocated_new_itables =3D=3D ALLOCATED_NEW_ITABLE_FIRST_ITERAT=
ION)
+=09=09rfs->allocated_new_itables =3D 0;
+
+=09if (rfs->allocated_new_itables =3D=3D rfs->old_fs->group_desc_count)
+=09=09return 0;
+
+=09for (group =3D 0; group < rfs->new_fs->group_desc_count; group++) {
+=09=09if (rfs->new_itable_status[group] !=3D itable_status_not_allocated)
+=09=09    continue;
+
+=09=09ext2fs_inode_table_loc_set(rfs->new_fs, group, 0);
+=09=09retval =3D ext2fs_allocate_group_table(rfs->new_fs, group, 0);
+=09=09if (retval =3D=3D EXT2_ET_BLOCK_ALLOC_FAIL) {
+#ifdef RESIZE2FS_DEBUG
+=09=09=09if (rfs->flags & RESIZE_DEBUG_INODECOUNT)
+=09=09=09=09printf("unsuccessful ext2fs_allocate_group_table"
+=09=09=09=09" for group %u with EXT2_ET_BLOCK_ALLOC_FAIL "
+=09=09=09=09"(%li), will retry later\n", group, retval);
+#endif
+=09=09} else if (!retval) {
+=09=09=09itable_start =3D ext2fs_inode_table_loc(rfs->new_fs, group);
+=09=09=09len =3D rfs->new_fs->inode_blocks_per_group;
+
+=09=09=09/*ext2fs_allocate_group_table() doesn't update stats in
+=09=09=09group if flex_bg is not set, we have to do it ourselves */
+=09=09=09if (!ext2fs_has_feature_flex_bg(rfs->new_fs->super))
+=09=09=09=09ext2fs_block_alloc_stats_range(rfs->new_fs,
+=09=09=09=09=09=09=09itable_start, len, +1);
+
+=09=09=09ext2fs_block_alloc_stats_range(rfs->old_fs,
+=09=09=09=09=09=09       itable_start,
+=09=09=09=09=09=09       len, +1);
+=09=09=09retval =3D ext2fs_zero_blocks2(rfs->new_fs,
+=09=09=09=09=09=09itable_start, len,
+=09=09=09=09=09=09&itable_start, &len);
+=09=09=09if (retval) {
+=09=09=09=09fprintf(stderr,
+=09=09=09=09=09_("\nCould not write %d blocks in "
+=09=09=09=09=09"inode table starting at %llu: %s\n"),
+=09=09=09=09=09len, (unsigned long long)
+=09=09=09=09=09itable_start, error_message(retval));
+=09=09=09=09goto errout;
+=09=09=09}
+#ifdef RESIZE2FS_DEBUG
+=09=09=09if (rfs->flags & RESIZE_DEBUG_INODECOUNT)
+=09=09=09=09printf("successful ext2fs_allocate_group_table "
+=09=09=09=09=09"for group %u with retval %li in block "
+=09=09=09=09=09"%llu\n", group, retval, itable_start);
+#endif
+=09=09=09if (ext2fs_has_feature_bigalloc(rfs->new_fs->super)) {
+=09=09=09=09fix_itables_stats_bigalloc(rfs->new_fs,
+=09=09=09=09=09=09=09   itable_start, len);
+=09=09=09=09fix_itables_stats_bigalloc(rfs->old_fs,
+=09=09=09=09=09=09=09   itable_start, len);
+=09=09=09}
+=09=09=09rfs->new_itable_status[group] =3D itable_status_allocated;
+=09=09=09(rfs->allocated_new_itables)++;
+=09=09} else {
+=09=09=09fprintf(stderr, "failed ext2fs_allocate_group_table for"
+=09=09=09=09" group %u with retval %li\n", group, retval);
+=09=09=09goto errout;
+=09=09}
+=09}
+
+=09io_channel_flush(rfs->new_fs->io);
+
+=09if (prev_allocated_new_itables !=3D ALLOCATED_NEW_ITABLE_FIRST_ITERATIO=
N
+=09      && prev_allocated_new_itables =3D=3D rfs->allocated_new_itables) =
{
+=09=09fprintf(stderr, "FATAL, breaking loop because no inode table "
+=09=09=09=09"could be allocated in last iteration\n");
+=09=09retval =3D ENOSPC;
+=09=09goto errout;
+=09}
+
+=09/*populate the newly allocated inode tables*/
+=09retval =3D migrate_inodes_forward_loop(rfs);
+=09if (retval)
+=09=09goto errout;
+
+ errout:
+=09return retval;
+}
+
+/*
+ * If there are no contiguous free blocks to allocate
+ * the new inode tables, this function will mark blocks
+ * to be moved to make room for them
+ */
+static errcode_t make_room_for_new_itables(ext2_resize_t rfs)
+{
+=09ext2_filsys fs =3D rfs->old_fs;
+=09ext2fs_block_bitmap meta_bmap;
+=09ext2_badblocks_list badblock_list =3D 0;
+=09unsigned int j;
+=09int flexbg_size =3D 1U << fs->super->s_log_groups_per_flex,
+=09=09retried_from_beginning =3D 0;
+=09dgrp_t g;
+=09blk64_t blk, blk2, first_blk, last_blk;
+=09blk64_t required_blocks =3D 0;
+=09errcode_t retval;
+
+=09if (!(rfs->flags & RESIZE_INCREASE_INODE_COUNT))
+=09=09return 0;
+
+        /*free data from any previous iteration*/
+=09if (rfs->reserve_blocks)
+=09=09ext2fs_free_block_bitmap(rfs->reserve_blocks);
+=09if (rfs->move_blocks)
+=09=09ext2fs_free_block_bitmap(rfs->move_blocks);
+
+=09if (rfs->allocated_new_itables =3D=3D fs->group_desc_count)
+=09=09return 0;
+
+=09retval =3D ext2fs_allocate_block_bitmap(fs, _("blocks to be moved"),
+=09=09=09=09=09 &rfs->move_blocks);
+=09if (retval)
+=09=09goto errout;
+
+=09retval =3D ext2fs_allocate_block_bitmap(fs, _("reserved blocks"),
+=09=09=09=09=09 &rfs->reserve_blocks);
+=09if (retval)
+=09=09goto errout;
+
+=09retval =3D ext2fs_allocate_block_bitmap(fs, _("meta-data blocks"),
+=09=09=09=09=09 &meta_bmap);
+=09if (retval)
+=09=09goto errout;
+
+=09retval =3D ext2fs_read_bb_inode(get_fs_of_ino(rfs, EXT2_BAD_INO),
+=09                              &badblock_list);
+=09if (retval)
+=09=09goto errout;
+
+=09/*exclude metadata from candidate blocks to be moved */
+=09retval =3D mark_table_blocks(rfs->old_fs, meta_bmap);
+=09if (retval)
+=09=09goto errout;
+
+=09for (g =3D 0; g < fs->group_desc_count; g++) {
+=09=09blk =3D ext2fs_inode_table_loc(rfs->new_fs, g);
+=09=09if (blk) {
+=09=09=09ext2fs_mark_block_bitmap_range2(meta_bmap, blk,
+=09=09=09=09=09rfs->new_fs->inode_blocks_per_group);
+=09=09}
+=09}
+
+=09for (g =3D 0; g < fs->group_desc_count; g++) {
+=09=09if (ext2fs_free_blocks_count(rfs->new_fs->super) <
+=09=09    rfs->new_fs->inode_blocks_per_group + required_blocks)
+=09=09=09break;=09/*don't search if we are not going to find */
+
+=09=09if (ext2fs_has_feature_flex_bg(fs->super)
+=09=09    && !(g % (1U << fs->super->s_log_groups_per_flex))) {
+=09=09=09first_blk =3D ext2fs_group_first_block2(fs,
+=09=09=09=09=09=09=09g & ~(flexbg_size - 1));
+=09=09=09last_blk =3D (g | (flexbg_size - 1) >=3D fs->group_desc_count - 1=
) ?
+=09=09=09=09ext2fs_blocks_count(fs->super) - 1 :
+=09=09=09=09ext2fs_group_first_block2(fs, (g | (flexbg_size - 1)) + 1) - 1=
;
+=09=09=09retried_from_beginning =3D 0;
+=09=09}
+=09=09if (rfs->new_itable_status[g] !=3D itable_status_not_allocated)
+=09=09=09continue;
+
+=09=09if (!ext2fs_has_feature_flex_bg(fs->super)) {
+=09=09=09first_blk =3D ext2fs_group_first_block2(fs, g);
+=09=09=09last_blk =3D (g =3D=3D fs->group_desc_count - 1) ?
+=09=09=09=09ext2fs_blocks_count(fs->super) - 1 :
+=09=09=09=09ext2fs_group_first_block2(fs, g + 1) - 1;
+=09=09}
+search_for_space:
+=09=09for (blk =3D first_blk; blk <=3D last_blk; blk++) {
+=09=09=09for (blk2 =3D blk, j =3D 0;
+=09=09=09     j < rfs->new_fs->inode_blocks_per_group
+=09=09=09     && blk2 <=3D last_blk; blk2++, j++) {
+=09=09=09=09if (ext2fs_test_block_bitmap2(meta_bmap, blk2)
+=09=09=09=09    || ext2fs_test_block_bitmap2(rfs->reserve_blocks, blk2)
+=09=09=09=09    || ext2fs_badblocks_list_test(badblock_list, blk2)) {
+=09=09=09=09=09blk =3D blk2;
+=09=09=09=09=09break;
+=09=09=09=09}
+=09=09=09}
+=09=09=09if (j =3D=3D rfs->new_fs->inode_blocks_per_group) {
+#ifdef RESIZE2FS_DEBUG
+=09=09=09=09if (rfs->flags & RESIZE_DEBUG_INODECOUNT)
+=09=09=09=09=09printf(" --->blocks to move in group %u "
+=09=09=09=09=09    "are %llu - %llu\n", g, blk, blk2 - 1);
+#endif
+=09=09=09=09ext2fs_mark_block_bitmap_range2(rfs->move_blocks,
+=09=09=09=09=09blk, rfs->new_fs->inode_blocks_per_group);
+=09=09=09=09ext2fs_mark_block_bitmap_range2(rfs->reserve_blocks,
+=09=09=09=09=09blk, rfs->new_fs->inode_blocks_per_group);
+=09=09=09/* multiplied by 2 to account for possible extent tree rebalancin=
g */
+=09=09=09=09required_blocks +=3D 2 * rfs->new_fs->inode_blocks_per_group;
+=09=09=09=09first_blk =3D blk2;
+=09=09=09=09break;
+=09=09=09}
+=09=09=09 /* break loop, enter next if about failed search */
+=09=09=09if (blk2 > last_blk) {
+=09=09=09=09blk =3D blk2;
+=09=09=09=09break;
+=09=09=09}
+=09=09}
+=09=09if (blk > last_blk) {
+=09=09/*ext2fs_allocate_group_table() -> flexbg_offset() will
+=09=09ultimately search from 0 up to the last block of the flex_bg
+=09=09group, but not afterwards */
+=09=09=09if (!retried_from_beginning
+=09=09=09    && ext2fs_has_feature_flex_bg(fs->super)) {
+=09=09=09=09retried_from_beginning =3D 1;
+=09=09=09=09first_blk =3D fs->super->s_first_data_block;
+=09=09=09=09goto search_for_space;
+=09=09=09}
+#ifdef RESIZE2FS_DEBUG
+=09=09=09if (rfs->flags & RESIZE_DEBUG_INODECOUNT)
+=09=09=09=09fprintf(stderr, "unable to locate a suitable "
+=09=09=09=09=09"area to make room for group %u\n", g);
+#endif
+=09=09=09break;
+=09=09}
+=09}
+
+ errout:
+=09if (meta_bmap)
+=09=09ext2fs_free_block_bitmap(meta_bmap);
+=09if (badblock_list)
+=09=09ext2fs_badblocks_list_free(badblock_list);
+
+=09return retval;
+
+}
diff --git a/resize/resize2fs.h b/resize/resize2fs.h
index 96a878a7..b294fe60 100644
--- a/resize/resize2fs.h
+++ b/resize/resize2fs.h
@@ -78,6 +78,7 @@ typedef struct ext2_sim_progress *ext2_sim_progmeter;
 #define RESIZE_DEBUG_ITABLEMOVE=09=090x0008
 #define RESIZE_DEBUG_RTRACK=09=090x0010
 #define RESIZE_DEBUG_MIN_CALC=09=090x0020
+#define RESIZE_DEBUG_INODECOUNT=09=090x0040
=20
 #define RESIZE_PERCENT_COMPLETE=09=090x0100
 #define RESIZE_VERBOSE=09=09=090x0200
@@ -85,6 +86,9 @@ typedef struct ext2_sim_progress *ext2_sim_progmeter;
 #define RESIZE_ENABLE_64BIT=09=090x0400
 #define RESIZE_DISABLE_64BIT=09=090x0800
=20
+#define RESIZE_INCREASE_INODE_COUNT=090x1000
+#define RESIZE_DECREASE_INODE_COUNT=090x2000
+
 /*
  * This structure is used for keeping track of how much resources have
  * been used for a particular resize2fs pass.
@@ -99,6 +103,12 @@ struct resource_track {
 =09unsigned long long bytes_written;
 };
=20
+typedef enum {
+=09itable_status_not_allocated =3D 0,=09/*must be zero*/
+=09itable_status_allocated =3D 1,
+=09itable_status_populated =3D 2
+} itable_status;
+
 /*
  * The core state structure for the ext2 resizer
  */
@@ -115,6 +125,14 @@ struct ext2_resize_struct {
 =09int=09=09flags;
 =09char=09=09*itable_buf;
=20
+=09/*
+=09 * Specific fields to change inode count
+=09 */
+=09unsigned int    new_inodes_per_group;
+=09unsigned int    *evacuated_inodes;
+=09itable_status   *new_itable_status;
+=09dgrp_t          allocated_new_itables;
+
 =09/*
 =09 * For the block allocator
 =09 */
@@ -141,7 +159,8 @@ struct ext2_resize_struct {
=20
=20
 /* prototypes */
-extern errcode_t resize_fs(ext2_filsys fs, blk64_t *new_size, int flags,
+extern errcode_t resize_fs(ext2_filsys fs, blk64_t *new_size,
+                           unsigned int new_inodes_per_group, int flags,
 =09=09=09   errcode_t=09(*progress)(ext2_resize_t rfs,
 =09=09=09=09=09    int pass, unsigned long cur,
 =09=09=09=09=09    unsigned long max));
@@ -151,6 +170,7 @@ extern errcode_t adjust_fs_info(ext2_filsys fs, ext2_fi=
lsys old_fs,
 =09=09=09=09blk64_t new_size);
 extern blk64_t calculate_minimum_resize_size(ext2_filsys fs, int flags);
 extern void adjust_new_size(ext2_filsys fs, blk64_t *sizep);
+extern errcode_t mark_table_blocks(ext2_filsys fs, ext2fs_block_bitmap bma=
p);
=20
=20
 /* extent.c */
diff --git a/tests/r_inode_count_decrease_translate_number/expect b/tests/r=
_inode_count_decrease_translate_number/expect
new file mode 100644
index 00000000..a9cf4930
--- /dev/null
+++ b/tests/r_inode_count_decrease_translate_number/expect
@@ -0,0 +1,41 @@
+Creating filesystem with 147456 1k blocks and 36864 inodes
+Superblock backups stored on blocks:=20
+=098193, 24577, 40961, 57345, 73729
+
+Allocating group tables:      =08=08=08=08=08done                         =
  =20
+Writing inode tables:      =08=08=08=08=08done                           =
=20
+Writing superblocks and filesystem accounting information:      =08=08=08=
=08=08done
+
+Checksum is 1569341821
+debugfs:  write file_outside file
+Allocated inode: 12
+debugfs:  copy_inode file <36864>
+debugfs:  seti <36864>
+debugfs:  ln <36864> file2
+debugfs:  sif <12> block[0] 0
+debugfs:  rm file
+
+debugfs:  set_bg 17 free_inodes_count 2047
+debugfs:  ssv free_inodes_count 36852
+debugfs:  quit
+=20
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 12/36864 files (0.0% non-contiguous), 10816/147456 blocks
+Changing inode count on the filesystem.
+The filesystem on test.img now has 144 inodes.
+
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 12/144 files (0.0% non-contiguous), 1636/147456 blocks
+debugfs:  dump /file2 file_outside
+debugfs:  quit
+=20
+../tests/progs/crcsum file_outside
+Checksum is 1569341821
diff --git a/tests/r_inode_count_decrease_translate_number/name b/tests/r_i=
node_count_decrease_translate_number/name
new file mode 100644
index 00000000..cc261215
--- /dev/null
+++ b/tests/r_inode_count_decrease_translate_number/name
@@ -0,0 +1 @@
+decrease inode count with number translate
diff --git a/tests/r_inode_count_decrease_translate_number/script b/tests/r=
_inode_count_decrease_translate_number/script
new file mode 100644
index 00000000..fb1d36bd
--- /dev/null
+++ b/tests/r_inode_count_decrease_translate_number/script
@@ -0,0 +1,76 @@
+
+if ! test -x $RESIZE2FS_EXE -o ! -x $DEBUGFS_EXE; then
+=09echo "$test_name: $test_description: skipped (no debugfs/resize2fs)"
+=09return 0
+fi
+
+LOG=3D$test_name.log
+OUT_TMP=3Dfile_outside
+EXP=3D$test_dir/expect
+fail=3D0
+
+$MKE2FS -N 36864 $TMPFILE 144m >> $LOG 2>&1
+
+
+echo AAAAAAAA > $OUT_TMP  2>> $LOG
+CSUM_1=3D$($CRCSUM $OUT_TMP)
+echo Checksum is $CSUM_1 >> $LOG
+
+
+#make sure we create an inode that needs to be translated for the test
+$DEBUGFS -w $TMPFILE >> $LOG 2>&1 << EOF
+write $OUT_TMP file
+copy_inode file <36864>
+seti <36864>
+ln <36864> file2
+sif <12> block[0] 0
+rm file
+set_bg 17 free_inodes_count 2047
+ssv free_inodes_count 36852
+quit
+EOF
+echo " " >> $LOG
+
+$FSCK -fy -N test_filesys $TMPFILE >> $LOG 2>&1 || fail=3D1
+
+$RESIZE2FS -i 136 -f $TMPFILE >> $LOG 2>&1 || fail=3D1
+
+$FSCK -fy -N test_filesys $TMPFILE >> $LOG 2>&1 || fail=3D1
+
+
+rm -f $OUT_TMP
+
+$DEBUGFS $TMPFILE >> $LOG 2>&1 << EOF
+dump /file2 $OUT_TMP
+quit
+EOF
+echo " " >> $LOG
+
+echo $CRCSUM $OUT_TMP >> $LOG 2>&1
+CSUM_2=3D$($CRCSUM $OUT_TMP)
+echo Checksum is $CSUM_2 >> $LOG
+
+rm -f $OUT_TMP $TMPFILE
+
+
+if test "$CSUM_1" !=3D "$CSUM_2"
+then
+=09fail=3D1
+=09echo crc check failed >> $LOG
+fi
+
+sed -f $cmd_dir/filter.sed  < $LOG > $LOG.new
+mv $LOG.new $LOG
+
+cmp -s $LOG $EXP || fail=3D1
+
+if [ "$fail" =3D 0 ]; then
+=09echo "$test_name: $test_description: ok"
+=09touch $test_name.ok
+else
+=09echo "$test_name: $test_description: failed"
+=09diff $DIFF_OPTS $LOG $EXP >> $test_name.failed
+fi
+
+unset CSUM_1 CSUM_2 LOG OUT_TMP fail
+
diff --git a/tests/r_inode_count_increase_almost_full/expect b/tests/r_inod=
e_count_increase_almost_full/expect
new file mode 100644
index 00000000..9efc8c65
--- /dev/null
+++ b/tests/r_inode_count_increase_almost_full/expect
@@ -0,0 +1,35 @@
+Creating filesystem with 147456 1k blocks and 36864 inodes
+Superblock backups stored on blocks:=20
+=098193, 24577, 40961, 57345, 73729
+
+Allocating group tables:      =08=08=08=08=08done                         =
  =20
+Writing inode tables:      =08=08=08=08=08done                           =
=20
+Writing superblocks and filesystem accounting information:      =08=08=08=
=08=08done
+
+Checksum is 3565307003
+debugfs:  mkdir test
+debugfs:  cd test
+debugfs:  write file_outside file_inside
+Allocated inode: 13
+debugfs:  quit
+=20
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 13/36864 files (0.0% non-contiguous), 123257/147456 blocks
+Changing inode count on the filesystem.
+The filesystem on test.img now has 54432 inodes.
+
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 13/54432 files (0.0% non-contiguous), 127649/147456 blocks
+debugfs:  dump /test/file_inside file_outside
+debugfs:  quit
+=20
+../tests/progs/crcsum file_outside
+Checksum is 3565307003
diff --git a/tests/r_inode_count_increase_almost_full/name b/tests/r_inode_=
count_increase_almost_full/name
new file mode 100644
index 00000000..c876654a
--- /dev/null
+++ b/tests/r_inode_count_increase_almost_full/name
@@ -0,0 +1 @@
+increase inode count fs almost full
diff --git a/tests/r_inode_count_increase_almost_full/script b/tests/r_inod=
e_count_increase_almost_full/script
new file mode 100644
index 00000000..bbdc5e17
--- /dev/null
+++ b/tests/r_inode_count_increase_almost_full/script
@@ -0,0 +1,67 @@
+
+if ! test -x $RESIZE2FS_EXE -o ! -x $DEBUGFS_EXE; then
+=09echo "$test_name: $test_description: skipped (no debugfs/resize2fs)"
+=09return 0
+fi
+
+LOG=3D$test_name.log
+OUT_TMP=3Dfile_outside
+EXP=3D$test_dir/expect
+fail=3D0
+
+$MKE2FS $TMPFILE 144m >> $LOG 2>&1
+
+dd if=3D/dev/zero  bs=3D4096 count=3D28000 status=3Dnone 2>>$LOG | tr '\00=
0' '\377' > $OUT_TMP  2>> $LOG
+CSUM_1=3D$($CRCSUM $OUT_TMP)
+echo Checksum is $CSUM_1 >> $LOG
+
+$DEBUGFS -w $TMPFILE >> $LOG 2>&1 << EOF
+mkdir test
+cd test
+write $OUT_TMP file_inside
+quit
+EOF
+echo " " >> $LOG
+
+$FSCK -fy -N test_filesys $TMPFILE >> $LOG 2>&1 || fail=3D1
+
+$RESIZE2FS -i 54400 -f $TMPFILE >> $LOG 2>&1 || fail=3D1
+
+$FSCK -fy -N test_filesys $TMPFILE >> $LOG 2>&1 || fail=3D1
+
+
+rm -f $OUT_TMP
+
+$DEBUGFS $TMPFILE >> $LOG 2>&1 << EOF
+dump /test/file_inside $OUT_TMP
+quit
+EOF
+echo " " >> $LOG
+
+echo $CRCSUM $OUT_TMP >> $LOG 2>&1
+CSUM_2=3D$($CRCSUM $OUT_TMP)
+echo Checksum is $CSUM_2 >> $LOG
+
+rm -f $OUT_TMP $TMPFILE
+
+if test "$CSUM_1" !=3D "$CSUM_2"
+then
+=09fail=3D1
+=09echo crc check failed >> $LOG
+fi
+
+sed -f $cmd_dir/filter.sed  < $LOG > $LOG.new
+mv $LOG.new $LOG
+
+cmp -s $LOG $EXP || fail=3D1
+
+if [ "$fail" =3D 0 ]; then
+=09echo "$test_name: $test_description: ok"
+=09touch $test_name.ok
+else
+=09echo "$test_name: $test_description: failed"
+=09diff $DIFF_OPTS $LOG $EXP >> $test_name.failed
+fi
+
+unset CSUM_1 CSUM_2 LOG OUT_TMP fail
+
--=20
2.43.0



