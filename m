Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DF7788669
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Aug 2023 13:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244465AbjHYLyS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Aug 2023 07:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244446AbjHYLyN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Aug 2023 07:54:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C685310FF
        for <linux-ext4@vger.kernel.org>; Fri, 25 Aug 2023 04:54:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D8011F7AB;
        Fri, 25 Aug 2023 11:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692964450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4wMKy/OX8up4EMhWi/hNRkPEPb2Rvi9BVS43yosZbAo=;
        b=YCH+1KtJQUTM8snqfFDCQReUPv6wpSwgvEfzTo0TMae5QDd7wyHugP6qWQOrBo4XG+goHf
        xAlcIMd9SrbG4uqY1PVmkJOGjYW+goSR898/lGzv3lR0ipVrwife6C8/EOMGFUTXTOJ2gJ
        sjKZWYQasKR8StIPNJkSKu7k66efSeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692964450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4wMKy/OX8up4EMhWi/hNRkPEPb2Rvi9BVS43yosZbAo=;
        b=nSJbjPUsZwjMDH2eOUTMZxC6VVpTAkm9e09SxjiKMBQr1e+dfGf+dtYtz/T6a02QgYjVUE
        p3S3NGrKTSgXsjAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6ED19138F9;
        Fri, 25 Aug 2023 11:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ReUDG2KW6GSoSAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 25 Aug 2023 11:54:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0CB77A0774; Fri, 25 Aug 2023 13:54:10 +0200 (CEST)
Date:   Fri, 25 Aug 2023 13:54:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/11] ext4: Cleanup read-only and fs aborted checks
Message-ID: <20230825115410.rvjmreiac6hclucm@quack3>
References: <20230616164553.1090-1-jack@suse.cz>
 <169107341682.1086009.5390893702477027431.b4-ty@mit.edu>
 <CAOQ4uxh-HCE+Fwat8SyAGF3fcFg-xa_tH9jsxCe8=qPfx73K0g@mail.gmail.com>
 <CAOQ4uxiAJ8_zsmUCjFzVOOZi0XQoak8+D4GFp1ADW-+EyL1Jtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiAJ8_zsmUCjFzVOOZi0XQoak8+D4GFp1ADW-+EyL1Jtw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 25-08-23 10:24:52, Amir Goldstein wrote:
> On Fri, Aug 25, 2023 at 10:15 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Aug 3, 2023 at 6:23 PM Theodore Ts'o <tytso@mit.edu> wrote:
> > >
> > >
> > > On Fri, 16 Jun 2023 18:50:46 +0200, Jan Kara wrote:
> > > > This series arised from me trying to fix races when the ext4 filesystem gets
> > > > remounted read-write and users can race in writes before quota subsystem is
> > > > prepared to take them. This particular problem got fixed in VFS in the end
> > > > but the cleanups are still good in my opinion so I'm submitting them. They
> > > > get rid of EXT4_MF_ABORTED flag and cleanup some sb_rdonly() checks.
> > > >
> > > > Honza
> > > >
> > > > [...]
> > >
> > > Applied, thanks!
> > >
> > > [01/11] ext4: Remove pointless sb_rdonly() checks from freezing code
> > >         commit: 98175720c9ed3bac857b0364321517cc2d695a3f
> > > [02/11] ext4: Use sb_rdonly() helper for checking read-only flag
> > >         commit: d5d020b3294b69eaf3b8985e7a37ba237849c390
> > > [03/11] ext4: Make ext4_forced_shutdown() take struct super_block
> > >         commit: eb8ab4443aec5ffe923a471b337568a8158cd32b
> > > [04/11] ext4: Make 'abort' mount option handling standard
> > >         commit: 22b8d707b07e6e06f50fe1d9ca8756e1f894eb0d
> > > [05/11] ext4: Drop EXT4_MF_FS_ABORTED flag
> > >         commit: 95257987a6387f02970eda707e55a06cce734e18
> > > [06/11] ext4: Avoid starting transaction on read-only fs in ext4_quota_off()
> > >         commit: e0e985f3f8941438a66ab8abb94cb011b9fb39a7
> > > [07/11] ext4: Warn on read-only filesystem in ext4_journal_check_start()
> > >         commit: e7fc2b31e04c46c9e2098bba710c9951c6b968af
> > > [08/11] ext4: Drop read-only check in ext4_init_inode_table()
> > >         commit: ffb6844e28ef6b9d76bee378774d7afbc3db6da9
> > > [09/11] ext4: Drop read-only check in ext4_write_inode()
> > >         commit: f1128084b40e520bea8bb32b3ff4d03745ab7e64
> > > [10/11] ext4: Drop read-only check from ext4_force_commit()
> > >         commit: 889860e452d7436ca72018b8a03cbd89c38d6384
> > > [11/11] ext4: Replace read-only check for shutdown check in mmp code
> > >         commit: 1e1566b9c85fbd6150657ea17f50fd42b9166d31
> > >
> > > Best regards,
> > > --
> > > Theodore Ts'o <tytso@mit.edu>
> >
> > Hi Jan,
> >
> > Yesterday I ran fanotify LTP tests on linux-next and noticed a regression
> > with fanotify22 which tests the FAN_FS_ERROR event on ext4.
> > It's 100% reproducible on my machine (see below).
> >
> > I've bisected the regression down to this series.
> 
> Forgot to say that the good baseline for the test is Christian's vfs.all
> branch merged into Linus' master and the regression is after merging
> commit 1e1566b9c85 from Ted's tree.

Thanks for report! I had a look and it is the LTP test that is problematic.

1) It has four testcases, each of which ends up triggering more or less
fatal error on this filesystem. However the filesystem is not unmounted &
mounted again between testcases so it assumes that we continue reporting
further errors after fatal filesystem shutdown. This is a wrong assumption
as after such fatal error it isn't really defined what succeeds and what
not.

2) The patchset in ext4 tree slightly changed the behavior of the 'abort'
mount option by unifying it with the filesystem shutdown functionality
because having two different ways to abort a filesystem led to places
checking one but not the other. As a result once the filesystem is
shutdown using the 'abort' mount option, we don't report any more errors
because it's kind of pointless noise - things are expected to fail on
shutdown filesystem. And this upsets the test.

I'll fix the test.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
