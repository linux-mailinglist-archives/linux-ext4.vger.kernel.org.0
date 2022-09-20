Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859785BDEC7
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Sep 2022 09:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiITHuf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Sep 2022 03:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiITHt7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Sep 2022 03:49:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDB9219D;
        Tue, 20 Sep 2022 00:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AU0mZCMIx8JARy0byW2BmRzgYXSYzSXxAhWcU08IaqY=; b=aUezXLcVpUDpj+rBGwR2e2Dq+j
        +m8n/y4046APNRMEDTF0ZqaDkAxglTlVUNTJr9E1Z6iC226V1Bog1WEQ2+K4ikDCcQlgIfO79QYEn
        goQtBRPP+NXjgTSijBjOyUanFbCeVbhd0zVD0jL5AzO3eoXRAf7sgibPwBwjIJpBRSuo6MlMOJVkH
        45Z1TPzd/6ND3EgH8tHfjOOybk9MqFcjdvPfa8IIrKATJFRTJJ/ua6OyNsUaM6kt5wiagvMuJ7Cav
        WHJ9MvPeN6mIa0F7Nz1cmXZ0IlQ7xW2U8RmCkN9IPpyqtDS+bJksjLZ3l0EsO/cbt4ePE8hMqOnbn
        EqnTWtdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaY0H-001Ung-4F; Tue, 20 Sep 2022 07:49:13 +0000
Date:   Tue, 20 Sep 2022 00:49:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
Message-ID: <YylweQAZkIdb5ixo@infradead.org>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915164826.1396245-5-sarthakkukreti@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 15, 2022 at 09:48:22AM -0700, Sarthak Kukreti wrote:
> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> 
> FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> sends a hint to (supported) thinly provisioned block devices to
> allocate space for the given range of sectors via REQ_OP_PROVISION.

So, how does that "provisioning" actually work in todays world where
storage is usually doing out of place writes in one or more layers,
including the flash storage everyone is using.  Does it give you one
write?  And unlimited number?  Some undecided number inbetween?  How
is it affected by write zeroes to that range or a discard?
