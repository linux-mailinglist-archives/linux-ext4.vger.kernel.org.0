Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E93504855
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Apr 2022 18:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiDQQeq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 Apr 2022 12:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbiDQQep (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 17 Apr 2022 12:34:45 -0400
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3312B3054C;
        Sun, 17 Apr 2022 09:32:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mx.ewheeler.net (Postfix) with ESMTP id 96F3F85;
        Sun, 17 Apr 2022 09:32:09 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
        by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id KUKJeRbwtXv8; Sun, 17 Apr 2022 09:32:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.ewheeler.net (Postfix) with ESMTPSA id 9E07F48;
        Sun, 17 Apr 2022 09:32:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 9E07F48
Date:   Sun, 17 Apr 2022 09:32:07 -0700 (PDT)
From:   Eric Wheeler <linux-block@lists.ewheeler.net>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: loop: it looks like REQ_OP_FLUSH could return before IO
 completion.
In-Reply-To: <7ae1f26a-cd09-85ff-2f4c-9e80af41ce66@kernel.dk>
Message-ID: <d867fce8-e252-a621-cadb-c658dd2906a@ewheeler.net>
References: <af3e552a-6c77-b295-19e1-d7a1e39b31f3@ewheeler.net> <YjfFHvTCENCC29WS@T590> <c03de7ac-63e9-2680-ca5b-8be62e4e177f@ewheeler.net> <bd5f9817-c65e-7915-18b-9c68bb34488e@ewheeler.net> <YldqnL79xH5NJGKW@T590> <5b3cb173-484e-db3-8224-911a324de7dd@ewheeler.net>
 <YlmBTtGdTH2xW1qT@T590> <YlpRrLmwe/TJucjz@infradead.org> <2815ce9-85f-7b56-be3f-7835eb9bb2c6@ewheeler.net> <7ae1f26a-cd09-85ff-2f4c-9e80af41ce66@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 16 Apr 2022, Jens Axboe wrote:
> On 4/16/22 2:05 PM, Eric Wheeler wrote:
> > On Fri, 15 Apr 2022, Christoph Hellwig wrote:
> >> On Fri, Apr 15, 2022 at 10:29:34PM +0800, Ming Lei wrote:
> >>> If ext4 expects the following order, it is ext4's responsibility to
> >>> maintain the order, and block layer may re-order all these IOs at will,
> >>> so do not expect IOs are issued to device in submission order
> >>
> >> Yes, and it has been so since REQ_FLUSH (which later became
> >> REQ_OP_FLUSH) replaced REQ_BARRIER 12 years ago:
> >>
> >> commit 28e7d1845216538303bb95d679d8fd4de50e2f1a
> >> Author: Tejun Heo <tj@kernel.org>
> >> Date:   Fri Sep 3 11:56:16 2010 +0200
> >>
> >> block: drop barrier ordering by queue draining
> >>     
> >>     Filesystems will take all the responsibilities for ordering requests
> >>     around commit writes and will only indicate how the commit writes
> >>     themselves should be handled by block layers.  This patch drops
> >>     barrier ordering by queue draining from block layer.
> > 
> > Thanks Christoph. I think this answers my original question, too.
> > 
> > You may have already answered this implicitly above.  If you would be so 
> > kind as to confirm my or correct my understanding with a few more 
> > questions:
> > 
> > 1. Is the only way for a filesystem to know if one IO completed before a 
> >    second IO to track the first IO's completion and submit the second IO 
> >    when the first IO's completes (eg a journal commit followed by the 
> >    subsequent metadata update)?  If not, then what block-layer mechanism 
> >    should be used?
> 
> You either need to have a callback or wait on the IO, there's no other
> way.
> 
> > 2. Are there any IO ordering flags or mechanisms in the block layer at 
> >    this point---or---is it simply that all IOs entering the block layer 
> >    can always be re-ordered before reaching the media?
> 
> No, no ordering flags are provided for this kind of use case. Any IO can
> be reordered, hence the only reliable solution is to ensure the previous
> have completed.

Perfect, thanks Jens!

> 
> -- 
> Jens Axboe
> 
> 



--
Eric Wheeler


