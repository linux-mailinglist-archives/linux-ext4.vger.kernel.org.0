Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E337691EB5
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Feb 2023 12:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjBJL4e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Feb 2023 06:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjBJL4d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Feb 2023 06:56:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263832111;
        Fri, 10 Feb 2023 03:56:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B79405CC83;
        Fri, 10 Feb 2023 11:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676030188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bjk55WMF4J92NpXSALr4vzW6P2C4weO2hpPlyhOs+OY=;
        b=BsvYw35kjpC2lCtiP3BkdEEOu3bhsaVVoj/cOiE6USQZSKCfgoa/jP4RJbjsv+tZI0DTeb
        +EQrPSqLcAabyBqlllIEm1oonilKExfpDo8p8n9LELukkQxXPy2HZUqdcERlp4ZPRp899K
        SyhpnOtfwnY4dkhmpfu2PmaZhL/DoNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676030188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bjk55WMF4J92NpXSALr4vzW6P2C4weO2hpPlyhOs+OY=;
        b=uErB3ty08v3HhVgl8uCOWkplw/dO+iFg6nN+LBBTA6BGMX/nWn9fa/nAjugSR72S/SADwT
        Tcer0p+nAIRIQfBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8CC013206;
        Fri, 10 Feb 2023 11:56:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gXwsKeww5mP7eAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 10 Feb 2023 11:56:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3058AA06D8; Fri, 10 Feb 2023 12:56:28 +0100 (CET)
Date:   Fri, 10 Feb 2023 12:56:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v2 0/6] fix error flag covered by journal recovery
Message-ID: <20230210115628.l6b4zukudqcp5hot@quack3>
References: <20230210032044.146115-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210032044.146115-1-yebin@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Fri 10-02-23 11:20:38, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Diff v2 vs v1:
> Move call 'j_replay_prepare_callback' and 'j_replay_end_callback' from
> ext4_load_journal() to jbd2_journal_recover().
> 
> When do fault injection test, got issue as follows:
> EXT4-fs (dm-5): warning: mounting fs with errors, running e2fsck is recommended
> EXT4-fs (dm-5): Errors on filesystem, clearing orphan list.
> EXT4-fs (dm-5): recovery complete
> EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: data_err=abort,errors=remount-ro
> 
> EXT4-fs (dm-5): recovery complete
> EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: data_err=abort,errors=remount-ro
> 
> Without do file system check, file system is clean when do second mount.
> Theoretically, the kernel will not clear fs error flag. In errors=remount-ro
> mode the last super block is commit directly. So super block in journal is
> not uptodate. When do jounral recovery, the uptodate super block will be
> covered by jounral data. If super block submit all failed after recover
> journal, then file system error flag is lost. When do "fsck -a" couldn't
> repair file system deeply.
> To solve above issue we need to do extra handle when do super block journal
> recovery.

Thanks for the patches. Looking through the patches, I think this is a bit
of an overengineering for the problem at hand. The only thing that is
really worth preserving so that it is not lost after journal replay is the
error information. So in ext4_load_journal() I would just save that if
EXT4_ERROR_FS is set in es->s_state before journal replay and restore it
after journal replay. Sure if the superblock write during journal replay
succeeds but the write restoring the error information fails, we will loose
the error information but that is so unlikely in practice that I don't
think it is really worth complicating the code for it. Also the only
downside is we will loose the information there is some error in the
filesystem - we'll soon find that out again anyway :).

								Honza

> 
> Ye Bin (6):
>   jbd2: introduce callback for recovery journal
>   ext4: introudce helper for jounral recover handle
>   jbd2: do extra handle when do journal recovery
>   ext4: remove backup for super block when recovery journal
>   ext4: fix super block checksum error
>   ext4: make sure fs error flag setted before clear journal error
> 
>  fs/ext4/ext4_jbd2.c  | 66 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/ext4/ext4_jbd2.h  |  2 ++
>  fs/ext4/super.c      | 18 ++++--------
>  fs/jbd2/recovery.c   | 27 ++++++++++++++++++
>  include/linux/jbd2.h | 11 ++++++++
>  5 files changed, 112 insertions(+), 12 deletions(-)
> 
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
