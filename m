Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB7C77757E
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 12:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbjHJKKU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 06:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjHJKKT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 06:10:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B1A83
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 03:10:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 94A1B1F749;
        Thu, 10 Aug 2023 10:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691662217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qpe+PchBwC1KJhD6237VXU0is5AHX+OifwdgLEwO2II=;
        b=DLDv2WCHkENuWKEeisLUDFMfa/2GsTxHxFxQXpaZyQlfqKQrHDYqY4ycRlPqscAU993dO1
        KSp8vmdnePbgPCBnlRQ1xuH8ZkZctHQ6ZQwGkxnL1NGVuB0AiFSSBWO3CZDFfm9WKmDBmV
        d3m+9UPCrxKD64/gU3dUvMuEJE7ErXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691662217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qpe+PchBwC1KJhD6237VXU0is5AHX+OifwdgLEwO2II=;
        b=2k6OFn/7VE9A//a+iGqcIlhHICSXRZEgVmO+L+EKq5/HDZw+rj4T/dmDmgnRCQZDVF1I/g
        44SM1kmLL2gY1PCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82A87138E0;
        Thu, 10 Aug 2023 10:10:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SnfdH4m31GQUEwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 10 Aug 2023 10:10:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0555FA076F; Thu, 10 Aug 2023 12:10:16 +0200 (CEST)
Date:   Thu, 10 Aug 2023 12:10:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 07/12] jbd2: add fast_commit space check
Message-ID: <20230810101016.jed6k7egldi3w5bv@quack3>
References: <20230810085417.1501293-1-yi.zhang@huaweicloud.com>
 <20230810085417.1501293-8-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810085417.1501293-8-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 10-08-23 16:54:12, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> If JBD2_FEATURE_INCOMPAT_FAST_COMMIT bit is set, it means the journal
> have fast commit records need to recover, so the fast commit size
> should not be too large, and the leftover normal journal size should
> never less than JBD2_MIN_JOURNAL_BLOCKS. If it happens, the
> journal->j_last is likely to be wrong and will probably lead to
> incorrect journal recovery. So add a check into the
> journal_check_superblock(), and drop the pointless check when
> initializing the fastcommit parameters.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Just one small note below. With that fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -1389,6 +1390,14 @@ static int journal_check_superblock(journal_t *journal)
>  		return err;
>  	}
>  
> +	num_fc_blks = jbd2_has_feature_fast_commit(journal) ?
> +				jbd2_journal_get_num_fc_blks(sb) : 0;
> +	if (be32_to_cpu(sb->s_maxlen) < JBD2_MIN_JOURNAL_BLOCKS + num_fc_blks) {

To avoid possible overflow of the right hand side, we should probably do
the check like:

	if (be32_to_cpu(sb->s_maxlen) < JBD2_MIN_JOURNAL_BLOCKS ||
	    be32_to_cpu(sb->s_maxlen) - JBD2_MIN_JOURNAL_BLOCKS < num_fc_blks) {
		...
	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
