Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED697660250
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Jan 2023 15:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbjAFOgZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Jan 2023 09:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjAFOgP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Jan 2023 09:36:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C93C67BF3;
        Fri,  6 Jan 2023 06:36:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01D1326572;
        Fri,  6 Jan 2023 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673015773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyA+rzUmCJe634szsMWfvCeiahqN7Z90H5rR+wJZupE=;
        b=Rlvt4yQlGWdaRnydMv0xO4Pc5jNWfo7pbJleru4LDu3pTUbN2rEMMZHk5H4JEMctXNUVwB
        U2LDa58Aw8vclgcnTzN/Kl8I/6Plszo8jZKPcQFzsnIGM0JcPWhX4snEm94GVbArexv5PQ
        Rb9juinfir4DfI5Ge3ObL7GcV+hQLzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673015773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyA+rzUmCJe634szsMWfvCeiahqN7Z90H5rR+wJZupE=;
        b=UTEVgsSJgNEhZF0g/FA9vfUhhnswavGd1JDAcG2Ss2SiJK6HFckesDAqaLBa099tiFLDgE
        6zCprhfL6wAuduCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7013139D5;
        Fri,  6 Jan 2023 14:36:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id izplONwxuGPLfQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 06 Jan 2023 14:36:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 64A1FA0742; Fri,  6 Jan 2023 15:36:12 +0100 (CET)
Date:   Fri, 6 Jan 2023 15:36:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com,
        =?utf-8?B?THXDrXM=?= Henriques <lhenriques@suse.de>
Subject: Re: [PATCH 2/2] ext4: update s_journal_inum if it changes after
 journal replay
Message-ID: <20230106143612.nzif3jndh7p32nej@quack3>
References: <20230106104706.2410740-1-libaokun1@huawei.com>
 <20230106104706.2410740-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230106104706.2410740-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 06-01-23 18:47:06, Baokun Li wrote:
> When mounting a crafted ext4 image, s_journal_inum may change after journal
> replay, which is obviously unreasonable because we have successfully loaded
> and replayed the journal through the old s_journal_inum. And the new
> s_journal_inum bypasses some of the checks in ext4_get_journal(), which
> may trigger a null pointer dereference problem. So if s_journal_inum
> changes after the journal replay, we ignore the change, and rewrite the
> current journal_inum to the superblock.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216541
> Reported-by: Luís Henriques <lhenriques@suse.de>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/super.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 260c1b3e3ef2..3fe9dc19ff9c 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5953,8 +5953,11 @@ static int ext4_load_journal(struct super_block *sb,
>  	if (!really_read_only && journal_devnum &&
>  	    journal_devnum != le32_to_cpu(es->s_journal_dev)) {
>  		es->s_journal_dev = cpu_to_le32(journal_devnum);
> -
> -		/* Make sure we flush the recovery flag to disk. */
> +		ext4_commit_super(sb);
> +	}
> +	if (!really_read_only && journal_inum &&
> +	    journal_inum != le32_to_cpu(es->s_journal_inum)) {
> +		es->s_journal_inum = cpu_to_le32(journal_inum);
>  		ext4_commit_super(sb);
>  	}
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
