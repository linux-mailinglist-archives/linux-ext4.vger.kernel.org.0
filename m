Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C047CF7AE
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 13:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjJSL5Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 07:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjJSL5X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 07:57:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25D9CF;
        Thu, 19 Oct 2023 04:57:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0177221A59;
        Thu, 19 Oct 2023 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697716640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gmRwmATguFntU5/41/ZcC5nz8p9WbJDCy+6CvfCvobM=;
        b=K1z4yfdIyqTYCEXUMU9mYyLu+z9zQJd/VWIZ8BwfK0F9ibMbVxg01KvhINiREbGIYbOQgC
        5gwXiqFvD8V3NqOJqktb0+3jEugbj2IY/I098ZKbxOlduiwnFvm1CUfHJ/fZ6iWVaXPZL7
        7Zx+rEXzsgVj2zmWlpikrxzOQqG2olI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697716640;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gmRwmATguFntU5/41/ZcC5nz8p9WbJDCy+6CvfCvobM=;
        b=47mH8V7JwKrxo+7f5zdtr52EQOMI9+ImvRFWAIggyQSHfsKPJY63PnDpUHoCuyVfmnDT97
        Uu2vYCTlWANTaSAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4B42139C2;
        Thu, 19 Oct 2023 11:57:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ohjQN58ZMWUOLgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 11:57:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4A695A06B0; Thu, 19 Oct 2023 13:57:19 +0200 (CEST)
Date:   Thu, 19 Oct 2023 13:57:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 4/4] ext4: reduce unnecessary memory allocation in
 alloc_flex_gd()
Message-ID: <20231019115719.54wd6q6dxanaodid@quack3>
References: <20231018114221.441526-1-libaokun1@huawei.com>
 <20231018114221.441526-5-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018114221.441526-5-libaokun1@huawei.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.87
X-Spamd-Result: default: False [-4.87 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-2.77)[98.99%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com]
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 18-10-23 19:42:21, Baokun Li wrote:
> When a large flex_bg file system is resized, the number of groups to be
> added may be small, and a large amount of memory that will not be used will
> be allocated. Therefore, resize_bg can be set to the size after the number
> of new_group_data to be used is aligned upwards to the power of 2. This
> does not affect the disk layout after online resize and saves some memory.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good, just one small comment below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>


> @@ -248,6 +250,14 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
>  	else
>  		flex_gd->resize_bg = flexbg_size;
>  
> +	/* Avoid allocating new groups that will not be used. */

Perhaps make the comment more understandable like:
	/* Avoid allocating large 'groups' array if not needed */

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
