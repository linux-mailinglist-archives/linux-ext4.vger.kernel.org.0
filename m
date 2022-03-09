Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D774D2CD8
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Mar 2022 11:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiCIKMA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Mar 2022 05:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiCIKL6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Mar 2022 05:11:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61AC16A5BB
        for <linux-ext4@vger.kernel.org>; Wed,  9 Mar 2022 02:10:59 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9C777210EE;
        Wed,  9 Mar 2022 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646820658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KzQ2m+w+wM5hzhgWmPch51aqnlv1ZH0RRI+SLiqmKXI=;
        b=rrm7E5ltGC0nOWLQR6PF8ctS5+bJUgCs7Vc345936Q4un9d1191g5y7zeWlmOsGz5CbuoL
        goJvfKQkzdE+yMCQ8CVcIiPK2ELiQ2TviwJt59OCqvJ2ai6npxHBPK6s0DhuxLncvlVkYv
        Yo6r5oM5LxNnxMaEOpxWAAX5zL16HF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646820658;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KzQ2m+w+wM5hzhgWmPch51aqnlv1ZH0RRI+SLiqmKXI=;
        b=7Oz/kxYKxCIzs5ypEn+ANi91+OmU1mSoWRKfrrD/LO8KZ0d4XrL7Hw0F7k9r38QstFTtiA
        R5J7fI7AHwlA3YDA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 83679A3B9A;
        Wed,  9 Mar 2022 10:10:58 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 00B48A060B; Wed,  9 Mar 2022 11:10:57 +0100 (CET)
Date:   Wed, 9 Mar 2022 11:10:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, riteshh@linux.ibm.com, jack@suse.cz,
        tytso@mit.edu
Subject: Re: [PATCH v2 1/5] ext4: convert i_fc_lock to spinlock
Message-ID: <20220309101057.3uuix2gvjinobt3i@quack3.lan>
References: <20220308163319.1183625-1-harshads@google.com>
 <20220308163319.1183625-2-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308163319.1183625-2-harshads@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 08-03-22 08:33:15, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> Convert ext4_inode_info->i_fc_lock to spinlock to avoid sleeping
> in invalid contexts.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

One comment below...

> @@ -972,9 +970,13 @@ static int ext4_fc_wait_inode_data_all(journal_t *journal)
>  
>  	spin_lock(&sbi->s_fc_lock);
>  	list_for_each_entry_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> +		spin_lock(&pos->i_fc_lock);
>  		if (!ext4_test_inode_state(&pos->vfs_inode,
> -					   EXT4_STATE_FC_COMMITTING))
> +					   EXT4_STATE_FC_COMMITTING)) {
> +			spin_unlock(&pos->i_fc_lock);
>  			continue;
> +		}
> +		spin_unlock(&pos->i_fc_lock);
>  		spin_unlock(&sbi->s_fc_lock);

Why do you add a lock here in a pure lock-conversion patch? Furthermore I
don't think the lock is needed...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
