Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7C978DAAA
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Aug 2023 20:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbjH3Sgv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Aug 2023 14:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245538AbjH3Pak (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Aug 2023 11:30:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13CBFB
        for <linux-ext4@vger.kernel.org>; Wed, 30 Aug 2023 08:30:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 88D3421862;
        Wed, 30 Aug 2023 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693409435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bi71MMVEilS9quQAdkruVBGYafEq5/wHIkSexy+eEME=;
        b=hu6GLl+lZAL2BbCQ3plsYhwz03RORZPfBx6ns9W9ZK9mZN0h+YnA91U0zs6Uje6AL88Jlo
        EGo2OaEGlxSyckWsIpAGNzsCyfyNy417sRt8T0Q2ylt1A7coWy38nQGfH4SuX3qAikZeme
        h4nhZvZiYjhK/ajmLDBHMKUNxbtcPx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693409435;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bi71MMVEilS9quQAdkruVBGYafEq5/wHIkSexy+eEME=;
        b=29rV619m91X790LmEmUhP1tHdv+rrrKoqhAWtuFozcNms/V76twFrybr1v2u75lQbVhMUs
        iBn4qquGo9grIkBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C24113441;
        Wed, 30 Aug 2023 15:30:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Cz9DHptg72QqMAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Aug 2023 15:30:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 14F52A0774; Wed, 30 Aug 2023 17:30:35 +0200 (CEST)
Date:   Wed, 30 Aug 2023 17:30:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH 00/16] ext4: more accurate metadata reservaion for
 delalloc mount option
Message-ID: <20230830153035.pnkmbuu5ra5xngp3@quack3>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Thu 24-08-23 17:26:03, Zhang Yi wrote:
> The delayed allocation method allocates blocks during page writeback in
> ext4_writepages(), which cannot handle block allocation failures due to
> e.g. ENOSPC if acquires more extent blocks. In order to deal with this,
> commit '79f0be8d2e6e ("ext4: Switch to non delalloc mode when we are low
> on free blocks count.")' introduce ext4_nonda_switch() to convert to no
> delalloc mode if the space if the free blocks is less than 150% of dirty
> blocks or the watermark.

Well, that functionality is there mainly so that we can really allocate all
blocks available in the filesystem. But you are right that since we are not
reserving metadata blocks explicitely anymore, it is questionable whether
we really still need this.

> In the meantime, '27dd43854227 ("ext4:
> introduce reserved space")' reserve some of the file system space (2% or
> 4096 clusters, whichever is smaller). Both of those to solutions can
> make sure that space is not exhausted when mapping delalloc blocks in
> most cases, but cannot guarantee work in all cases, which could lead to
> infinite loop or data loss (please see patch 14 for details).

OK, I agree that in principle there could be problems due to percpu
counters inaccuracy etc. but were you able to reproduce the problem under
some at least somewhat realistic conditions? We were discussing making
free space percpu counters switch to exact counting in case we are running
tight on space to avoid these problems but it never proved to be a problem
in practice so we never bothered to actually implement it.

> This patch set wants to reserve metadata space more accurate for
> delalloc mount option. The metadata blocks reservation is very tricky
> and is also related to the continuity of physical blocks, an effective
> way is to reserve as the worst case, which means that every data block
> is discontinuous and one data block costs an extent entry. Reserve
> metadata space as the worst case can make sure enough blocks reserved
> during data writeback, the unused reservaion space can be released after
> mapping data blocks.

Well, as you say, there is a problem with the worst case estimates - either
you *heavily* overestimate the number of needed metadata blocks or the code
to estimate the number of needed metadata blocks is really complex. We used
to have estimates of needed metadata and we ditched that code (in favor of
reserved clusters) exactly because it was complex and suffered from
cornercases that were hard to fix. I haven't quite digested the other
patches in this series to judge which case is it but it seems to lean on
the "complex" side :).

So I'm somewhat skeptical this complexity is really needed but I can be
convinced :).

> After doing this, add a worker to submit delayed
> allocations to prevent excessive reservations. Finally, we could
> completely drop the policy of switching back to non-delayed allocation.

BTW the worker there in patch 15 seems really pointless. If you do:
queue_work(), flush_work() then you could just directly do the work inline
and get as a bonus more efficiency and proper lockdep tracking of
dependencies. But that's just a minor issue I have noticed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
