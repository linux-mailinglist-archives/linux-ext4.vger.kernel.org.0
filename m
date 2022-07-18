Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406A35786FF
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Jul 2022 18:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiGRQJB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Jul 2022 12:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiGRQJB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Jul 2022 12:09:01 -0400
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798EFDE8D
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jul 2022 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1658160534;
        bh=0lfHJvpbNf5L5KF4whcIbe+BAaJX1UhLEmpUFS85+0U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eg06lIM0pUQcZX3u/X/2YjbGhxqBGj/A7VOgFTBHeZkl06RRub2zMACh+OQm42m1L
         OJf5uBVpE43rcC/F/3Ba815ZDL3PsTYpGZWmCyQd0+bgIPUmSQtJUOtySiJCoA936q
         gveXX9bs8m7LGphjeuYqo86gX0QtPJENwbcOHmrA=
Received: from [192.168.50.235] ([123.112.69.211])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id 23511832; Tue, 19 Jul 2022 00:08:53 +0800
X-QQ-mid: xmsmtpt1658160533t44c0c334
Message-ID: <tencent_2388D8723F1AA7A28CD89C137C0FFCDE1806@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85No4Q5hHTrsn8i2yTV5vJRVJupt581o5QYJWSlCXoOMSirz5qiHeo
         gDHZr1l84LXfbJMK8SUtxe3DgtXmwQiOLR18gd5Gmrp2tmkpedaY37vtS8ppwSuj7CH+25lJZCuV
         0QsLCAjruU0gHRIefY1HgGr0AZD55Te1TDCNwXa2SBkhKaKmyI38RIXIwEsmL+hbrsyp8ugQ54y5
         E7t8yxWeZ6ijBlJewi9DzhxPxz3CSGx/HIwTh7K+RdQ1yCA/jhEt5Yft47nrdBRzKH++zEcrF2nO
         4K4fYHWgbDM8g3E3npC7l1cP9aIU7fe99zkSiDaz5aSyxMxBQ6JpJeZTH5d1p7fM07byjcEAagIs
         ryG6Y0iKl557E6HB5WqiUz190hH09TWeOQANKb1lKOCxJGNLG/VNV2ehpD+Ca2HXrm1gZ3T/uA0R
         KNDidNb8LJ9twi3+w6YiMGuDd5cgakQ9mNL5/XwBkxHyNYo9/4zPMnh/V5VX6HmUhwGk/K00niDF
         dG4e/KomTQHfb3+5qrn8QhSGnDGWWdERXXLoA1O0VgIyiGjucr85KxJlytws5zxKTsxkhlBAec3W
         cZ9BjoIujwTKvMpNRKVfmcE12t1QdnKHSDJiH8ojmJ5uZT1HvhRpt/F/ez2jeSqLr+zT2dV+dif7
         qt4X6D5Ue98wLIjCXK4JxsHoLsBVVPfQKPTPUOxNlT8wTqUerXtNMgb9+E+cx5zoIpd7Gdf+JOBW
         HAloAIPmKoy4qjYjl+8x++iv+b/z7SAE0kCRtNfSDWfCa5zApbivhEsDDjyyrsuUYkCyf+jomj/V
         uLLJIgu+lr6nBd1dSZf1EVwMbCT3BrQ7zAikOSXwcI970tNxYkvoluBhws+8NijNfy7gbFlqPV91
         BEkpuuPMoDzUNY8G2vTPcFyzeT4SNLj+0K/y7Mo+pVA5XM3XH5G++zx1tGrk3mhRy2FthhEFVfwh
         jN10B73d1KkyNhga0fkg==
X-OQ-MSGID: <56db9305-67c1-085e-868b-556b7253654d@foxmail.com>
Date:   Tue, 19 Jul 2022 00:08:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] jbd2: Set the right uuid for block tag
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <tencent_D668868A37626B4E053D6D7B5320DBCB1C08@qq.com>
 <tencent_8CDB89A1076C8F0FE46F79120D40114BAC05@qq.com>
 <YtGnK3wrxf52YyyB@mit.edu>
From:   Wang Jianjian <wangjianjian0@foxmail.com>
In-Reply-To: <YtGnK3wrxf52YyyB@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Gotcha, Thanks for your detailed explanation!

On 7/16/22 01:43, Theodore Ts'o wrote:
> On Fri, Jul 15, 2022 at 11:11:23PM +0800, Wang Jianjian wrote:
>> Hi all,
>> Is this a real problem need to fix ?
>>
>> On 7/12/22 00:26, Wang Jianjian wrote:
>>> journal->j_uuid is not initialized and let us use the uuid from
>>> j_superblock. And since this is the only place where j_uuid is used
>>> so that we can remove it.
> 
> There's a really long story, and the short version is, we don't really
> need to do anything.
> 
> The longer version of the story is that journal->j_uuid is not
> supposed to be the uuid from the journal superblock, but rather the
> uuid from the file system.  Quoting from the jbd2.h header file:
> 
> 	/**
> 	 * @j_uuid:
> 	 *
> 	 * Journal uuid: identifies the object (filesystem, LVM volume etc)
> 	 * backed by this journal.  This will eventually be replaced by an array
> 	 * of uuids, allowing us to index multiple devices within a single
> 	 * journal and to perform atomic updates across them.
> 	 */
> 	__u8			j_uuid[16];
> 
> The original design goal from Stephen Tweedie, who implemented the jbd
> subsystem for ext3, was that the jbd/jbd2 layer could in theory be
> used for more than just ext3/ext4 (and indeed, it is used by
> ocfs/ocfs2), *and*, that in the case of a journal on an external
> device, that a single jbd/jbd2 journal could support multiple file
> systems.  So you might have a dozen HDD's in a NAS box, and they would
> all use a single extrenal device as a journal.
> 
> So at the beginning of each block (or revoke) tag, there is a space
> for a UUID to indicate what file system that the metadata blocks being
> journaled was for.  Those bits are skipped if the JBD2_FLAG_SAME_UUID
> is set, in which case the tag is assumed to belong to the same file
> system as the previous tag.
> 
> The on-disk space has been reserved for this design; we have
> JBD2_FLAG_SAME_UUID, and that's why we copy the j_uuid into the tag
> block for the first tag, and all other tags gave the SAME_UUID flag
> set.  In addition, in the on-disk superblock, we define an array of
> UUID's which are the file systems which use this particular external
> journal:
> 
> /* 0x0100 */
> 	__u8	s_users[16*48];		/* ids of all fs'es sharing the log */
> 
> However, full support for having multiple file systems sharing the
> long was never realized.  Part of the reason for this is there are
> complications if one of the disks is off-line at the time that the
> journal is replayed.  Suppose out of the dozen file systems sharing an
> external journal, one of the HDD's is temporarily off-line, or removed
> from the NAS box.  Now we can't replay the journal, since there is no
> place to put the journal enrties for the missing file system(s).  In
> theory we could copy the journal entries for the missing file system
> in an file, but then we would have to define some place on the root
> file system where the saved journals for the missing HDD could be
> found, and that assumes that the root file system is mounted
> read/write so it's available to save the journal information.
> 
> Another potential problem is that when we *do* need to do a commit, we
> have to wait for handles for *all* of the file systems using that
> journal to complete, and so an fsync() triggered on one file system
> would potentially hold up file system operations on a sibling device.
> 
> There might be cases where this would make sense, they would be pretty
> specialized situations, and so never has ever decided to implement the
> rest of the feature.
> 
> At the moment journal->j_uuid is all zeros after
> journal_init_common(), and so we're wasting 16 bytes in each journal
> descriptor block by filling in those bytes with all zeroes.  The
> proper way to "fix" this would be in fs/ext4/super.c, in the functions
> ext4_get_inode() and ext4_get_dev_journal(), after those functions
> call jbd2_journal_init_{dev,inode}, they should copy
> EXT4_SB(super)->s_uuid into journal->j_uuid.
> 
> That would properly "initialize" journal->j_uuid, and it would mean
> that the file system uuid would be in the tag block.  One potential
> gotcha if we were to make this change, and if we wanted to actually
> check the uuid in the jbd2 descriptor block, is that today, tune2fs,
> and the proposed EXT4_IOC_SETUUID ioctl assume that we can change the
> file system uuid without having any potential problems.
> 
> If we wanted to properly support this case in the EXT4_IOC_SETUUID
> patch, we would have to freeze the file system by calling
> ext4_freeze() and then update journal->j_uuid, as well as update
> jsb->s_users[] if we are using an external journal.
> 
> And for the existing userspace-only "tune2fs -U" code, we currently
> don't have a way of triggering an update of the journal->j_uuid field
> when the file system uuid is changed.  (We do update the journal
> superblock s_users array, but if we did that while the file system was
> mounted, it wouldn't be safe unless it called FIFREEZE/FITHAW, which
> it currently doesn't do.)
> 
> So we could initialize journal->j_uuid if we wanted to, which wouldn't
> do much harm, but it wouldn't really fix anything either --- and then
> we'd have to make sure that journal is quicesed, and journal->j_uuid
> gets updated if the file system UUID is changed while the file system
> is mounted.  Once the first tag in the jbd2 descriptor block is now
> set correctly, we would then have to find a profitable way to *use*
> that information --- either as an additional sanity check on top of
> the checksum, or to implement the full support for shared uses for the
> journal.  But since the journal checksums are good enough that we
> don't need the additional validation, and there hasn't been a real
> demand for shared external journals, it probably won't happen until
> someone wants to make a business case and fund the engineering work to
> make it happen.
> 
> Cheers,
> 
> 						- Ted
> 						
> 
