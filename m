Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519F9576641
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 19:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiGORn1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jul 2022 13:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiGORnW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jul 2022 13:43:22 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73D7868BC
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 10:43:14 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26FHh7Ok010057
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 13:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657906989; bh=O/rL36vDumKOh+3CLXiarB+9KsxysZO2mbpUe5DCOQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lAz6Bh9K2CEAXIGRLCZArO86Re+e4HlDoqZX1azfjizoLpD/HE/zB12dK/mOlpobl
         YZ5h5SsL2Z5RQ+aawKtDZieWIyrOhQj7rJWgflNrmbNP+oipXakkaxLwQkNGfrAbaQ
         F8df31PHo7hFXvytyJS7t0j2aezV66pfpoFF6iMOu27Fqym92YJNJwnL8ptMx8Wrft
         7ezxfMRgGi1Ik9flx9WAeuObyLG3GxicYVuTSZVrdv51DZ1X38gKI1ZIs0TtyPtiQI
         kLtIom4SAYEn6JaYEZAPsnRvqBVZLp4Kaxjz1LZzMgUSA6h0LmYG4njY6GSlQANJPG
         yfscKYG1BupiQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6EA5615C003C; Fri, 15 Jul 2022 13:43:07 -0400 (EDT)
Date:   Fri, 15 Jul 2022 13:43:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wang Jianjian <wangjianjian0@foxmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] jbd2: Set the right uuid for block tag
Message-ID: <YtGnK3wrxf52YyyB@mit.edu>
References: <tencent_D668868A37626B4E053D6D7B5320DBCB1C08@qq.com>
 <tencent_8CDB89A1076C8F0FE46F79120D40114BAC05@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8CDB89A1076C8F0FE46F79120D40114BAC05@qq.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 15, 2022 at 11:11:23PM +0800, Wang Jianjian wrote:
> Hi all,
> Is this a real problem need to fix ?
> 
> On 7/12/22 00:26, Wang Jianjian wrote:
> > journal->j_uuid is not initialized and let us use the uuid from
> > j_superblock. And since this is the only place where j_uuid is used
> > so that we can remove it.

There's a really long story, and the short version is, we don't really
need to do anything.

The longer version of the story is that journal->j_uuid is not
supposed to be the uuid from the journal superblock, but rather the
uuid from the file system.  Quoting from the jbd2.h header file:

	/**
	 * @j_uuid:
	 *
	 * Journal uuid: identifies the object (filesystem, LVM volume etc)
	 * backed by this journal.  This will eventually be replaced by an array
	 * of uuids, allowing us to index multiple devices within a single
	 * journal and to perform atomic updates across them.
	 */
	__u8			j_uuid[16];

The original design goal from Stephen Tweedie, who implemented the jbd
subsystem for ext3, was that the jbd/jbd2 layer could in theory be
used for more than just ext3/ext4 (and indeed, it is used by
ocfs/ocfs2), *and*, that in the case of a journal on an external
device, that a single jbd/jbd2 journal could support multiple file
systems.  So you might have a dozen HDD's in a NAS box, and they would
all use a single extrenal device as a journal.

So at the beginning of each block (or revoke) tag, there is a space
for a UUID to indicate what file system that the metadata blocks being
journaled was for.  Those bits are skipped if the JBD2_FLAG_SAME_UUID
is set, in which case the tag is assumed to belong to the same file
system as the previous tag.

The on-disk space has been reserved for this design; we have
JBD2_FLAG_SAME_UUID, and that's why we copy the j_uuid into the tag
block for the first tag, and all other tags gave the SAME_UUID flag
set.  In addition, in the on-disk superblock, we define an array of
UUID's which are the file systems which use this particular external
journal:

/* 0x0100 */
	__u8	s_users[16*48];		/* ids of all fs'es sharing the log */

However, full support for having multiple file systems sharing the
long was never realized.  Part of the reason for this is there are
complications if one of the disks is off-line at the time that the
journal is replayed.  Suppose out of the dozen file systems sharing an
external journal, one of the HDD's is temporarily off-line, or removed
from the NAS box.  Now we can't replay the journal, since there is no
place to put the journal enrties for the missing file system(s).  In
theory we could copy the journal entries for the missing file system
in an file, but then we would have to define some place on the root
file system where the saved journals for the missing HDD could be
found, and that assumes that the root file system is mounted
read/write so it's available to save the journal information.

Another potential problem is that when we *do* need to do a commit, we
have to wait for handles for *all* of the file systems using that
journal to complete, and so an fsync() triggered on one file system
would potentially hold up file system operations on a sibling device.

There might be cases where this would make sense, they would be pretty
specialized situations, and so never has ever decided to implement the
rest of the feature.

At the moment journal->j_uuid is all zeros after
journal_init_common(), and so we're wasting 16 bytes in each journal
descriptor block by filling in those bytes with all zeroes.  The
proper way to "fix" this would be in fs/ext4/super.c, in the functions
ext4_get_inode() and ext4_get_dev_journal(), after those functions
call jbd2_journal_init_{dev,inode}, they should copy
EXT4_SB(super)->s_uuid into journal->j_uuid.

That would properly "initialize" journal->j_uuid, and it would mean
that the file system uuid would be in the tag block.  One potential
gotcha if we were to make this change, and if we wanted to actually
check the uuid in the jbd2 descriptor block, is that today, tune2fs,
and the proposed EXT4_IOC_SETUUID ioctl assume that we can change the
file system uuid without having any potential problems.

If we wanted to properly support this case in the EXT4_IOC_SETUUID
patch, we would have to freeze the file system by calling
ext4_freeze() and then update journal->j_uuid, as well as update
jsb->s_users[] if we are using an external journal.

And for the existing userspace-only "tune2fs -U" code, we currently
don't have a way of triggering an update of the journal->j_uuid field
when the file system uuid is changed.  (We do update the journal
superblock s_users array, but if we did that while the file system was
mounted, it wouldn't be safe unless it called FIFREEZE/FITHAW, which
it currently doesn't do.)

So we could initialize journal->j_uuid if we wanted to, which wouldn't
do much harm, but it wouldn't really fix anything either --- and then
we'd have to make sure that journal is quicesed, and journal->j_uuid
gets updated if the file system UUID is changed while the file system
is mounted.  Once the first tag in the jbd2 descriptor block is now
set correctly, we would then have to find a profitable way to *use*
that information --- either as an additional sanity check on top of
the checksum, or to implement the full support for shared uses for the
journal.  But since the journal checksums are good enough that we
don't need the additional validation, and there hasn't been a real
demand for shared external journals, it probably won't happen until
someone wants to make a business case and fund the engineering work to
make it happen.

Cheers,

						- Ted
						
