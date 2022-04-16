Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698D7503427
	for <lists+linux-ext4@lfdr.de>; Sat, 16 Apr 2022 07:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiDPFVL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 16 Apr 2022 01:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiDPFVL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 16 Apr 2022 01:21:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26A6EB089;
        Fri, 15 Apr 2022 22:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g+ujJVVDoFg2B4P01ECtm57Vr62I/0DX7wK8TNkFwYU=; b=EKriTvTdng77iAKQoyYG6B5/VV
        5OVUPDyFrE6pmPGmccjCI5RnxYElNCQzLnaOMjV1+aazGiETaUlqPpnoE4cupYU/skXt1620cyZxr
        Q3csBuph9OxtbU1UA4xK0S1pCOd/jE5Sg+f5RR8p9Y6DRiZcXma5uBVVaEz9HrC/Riy4fSh2pzHp4
        4JrNXR2FCjceXhTJF1oObVnIBVl3OQH9hrO13WcPRT39+BSsBeD881zufHquRmsvHKrHjqG3ZTtT2
        62qJYsZ2RxvQ6XO4iWJtROJgGsfO4E7TET5bxE2MkxjBxBF1IEAQQrLfmU2S8KXzK7fF0gg2kVxmw
        z+z7FeMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfapQ-00CGcz-82; Sat, 16 Apr 2022 05:18:36 +0000
Date:   Fri, 15 Apr 2022 22:18:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Eric Wheeler <linux-block@lists.ewheeler.net>,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: loop: it looks like REQ_OP_FLUSH could return before IO
 completion.
Message-ID: <YlpRrLmwe/TJucjz@infradead.org>
References: <af3e552a-6c77-b295-19e1-d7a1e39b31f3@ewheeler.net>
 <YjfFHvTCENCC29WS@T590>
 <c03de7ac-63e9-2680-ca5b-8be62e4e177f@ewheeler.net>
 <bd5f9817-c65e-7915-18b-9c68bb34488e@ewheeler.net>
 <YldqnL79xH5NJGKW@T590>
 <5b3cb173-484e-db3-8224-911a324de7dd@ewheeler.net>
 <YlmBTtGdTH2xW1qT@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlmBTtGdTH2xW1qT@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 15, 2022 at 10:29:34PM +0800, Ming Lei wrote:
> If ext4 expects the following order, it is ext4's responsibility to
> maintain the order, and block layer may re-order all these IOs at will,
> so do not expect IOs are issued to device in submission order

Yes, and it has been so since REQ_FLUSH (which later became
REQ_OP_FLUSH) replaced REQ_BARRIER 12 years ago:

commit 28e7d1845216538303bb95d679d8fd4de50e2f1a
Author: Tejun Heo <tj@kernel.org>
Date:   Fri Sep 3 11:56:16 2010 +0200

block: drop barrier ordering by queue draining
    
    Filesystems will take all the responsibilities for ordering requests
    around commit writes and will only indicate how the commit writes
    themselves should be handled by block layers.  This patch drops
    barrier ordering by queue draining from block layer.

