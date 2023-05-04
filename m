Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E293E6F62F9
	for <lists+linux-ext4@lfdr.de>; Thu,  4 May 2023 04:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEDCmN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 22:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEDCmM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 22:42:12 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7141E42
        for <linux-ext4@vger.kernel.org>; Wed,  3 May 2023 19:42:10 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3442fwbm011830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 22:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683168123; bh=eTCuQQB8yacNMzkTzo2O6BZ9pz+ntZF06EuAP3MO3FE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=joIpqTZO0iOaq+VVu1pFERnpUALgscJWuyuWUXBw6vwZgCaBb+xbqBQtgXSYm/IhA
         85FU4jiL0aebQh98yWEYT7RWSFB2esoQx0dideQF+59GKXQ2m6Sbz5rUbI3WlMOTJg
         9rrviasRtv9zJDNlYjN1fdn71W/tEBfnPSTOUqp3U/MeVxu6PA4SBbyKuAct3k2aaI
         8M4XFaQBr0JOvHPaadq26lh7bPW4RzuWSmUF6iqKRt7ERtEG7zQsGpCWjVVbEjPnq1
         Hxv1tqLXoPQRYiJr9S2mvBjkcnumAALliUvKpq9Gip32L8YyZlbMZkn+Rfwc+L8WIN
         FVkmmGcwx7e+Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D7A6915C02E2; Wed,  3 May 2023 22:41:57 -0400 (EDT)
Date:   Wed, 3 May 2023 22:41:57 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Fix data races when using cached status extents
Message-ID: <20230504024157.GB650928@mit.edu>
References: <20230503182128.14115-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503182128.14115-1-jack@suse.cz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 03, 2023 at 08:21:28PM +0200, Jan Kara wrote:
> When using cached extent stored in extent status tree in tree->cache_es
> another process holding ei->i_es_lock for reading can be racing with us
> setting new value of tree->cache_es. If the compiler would decide to
> refetch tree->cache_es at an unfortunate moment, it could result in a
> bogus in_range() check. Fix the possible race by using READ_ONCE() when
> using tree->cache_es only under ei->i_es_lock for reading.
> 
> Reported-by: syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/000000000000d3b33905fa0fd4a6@google.com
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Don't we also need a WRITE_ONCE here?

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7bc221038c6c..4694582cf255 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -293,7 +293,7 @@ static void __es_find_extent_range(struct inode *inode,
 	}
 
 	if (es1 && matching_fn(es1)) {
-		tree->cache_es = es1;
+		WRITE_ONCE(tree->cache_es, es1);
 		es->es_lblk = es1->es_lblk;
 		es->es_len = es1->es_len;
 		es->es_pblk = es1->es_pblk;

					- Ted
