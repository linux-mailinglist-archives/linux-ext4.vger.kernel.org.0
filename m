Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE215BE480
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Sep 2022 13:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiITLae (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Sep 2022 07:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiITLa1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Sep 2022 07:30:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2946D1EEEB;
        Tue, 20 Sep 2022 04:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ufnh2nMLFWVGqIEbVXFQ5bFlJnUCbH6WOUk2G18r1y8=; b=WOaF0pb2mROTLVZj6oPFh/FEVU
        Dl8UExUWm8T66UeCdjXNE09c88ke2G80M4GgWN3ICQ41JHgfvY7DeVuOKLU3QrAyedUw6Gkd9c/JZ
        xzASYsIw47hVIvPfhdZlxwcIpeIfsMs1aoI4pFyhCieMxjdDFlHcIqyn9Bjk119xt+LQQgeVeHgW9
        JiG6T7qdN37W/Rc1zdKr3aD/JgQCwyS3Ezmw7EaAupUS/Q+ffG3TkQzgpV6R3eO/Z9WiFAeb8lAeR
        B67xStuif2T9Mk2ap53GV7HCBlxGa2Dt8whgMwfgbOtYL7aU4wj1hqfjdyVe/wTc8PXEQEnDHPej4
        MqMWmAcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oabSC-003JT4-DQ; Tue, 20 Sep 2022 11:30:16 +0000
Date:   Tue, 20 Sep 2022 04:30:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniil Lunev <dlunev@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Stefan Hajnoczi <stefanha@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
Message-ID: <YymkSDsFVVg1nbDP@infradead.org>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <YyQTM5PRT2o/GDwy@fedora>
 <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
 <Yylvvm3zVgqpqDrm@infradead.org>
 <CAAKderPF5Z5QLxyEb80Y+90+eR0sfRmL-WfgXLp=eL=HxWSZ9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAKderPF5Z5QLxyEb80Y+90+eR0sfRmL-WfgXLp=eL=HxWSZ9g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 20, 2022 at 08:17:10PM +1000, Daniil Lunev wrote:
> to WRITE ZERO command in NVMe, but to WRITE UNAVAILABLE in

There is no such thing as WRITE UNAVAILABLE in NVMe.

> NVME 2.0 spec, and to UNMAP ANCHORED in SCSI spec.

The SCSI anchored LBA state is quite complicated, and in addition
to UNMAP you can also create it using WRITE SAME, which is at least
partially useful, as it allows for sensible initialization pattern.
For the purpose of Linux that woud be 0.

That being siad you still haven't actually explained what problem
you're even trying to solve.
