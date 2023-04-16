Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00246E3549
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Apr 2023 07:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjDPF4b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 01:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDPF4b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 01:56:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9952D52
        for <linux-ext4@vger.kernel.org>; Sat, 15 Apr 2023 22:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NRUgc0+3mF8ocmKC/1ZSJa0r0TpeHHNJXlCwzUYF9GM=; b=4T4NUOjQyzryZsGwLao6txNw+c
        DFS1Iw7YZaRAuP59pLece1uElls7tnZ0gaZeTTh5Dpii2yUS0w+IjiJijoU6XOkzngjcx8ivio+DZ
        MwP6T9pdJPOLm67yBqKXGz8gho69vABitwbIcQ0wPC20m+dyFSs9OtIOE17xAvW0bIktqfzmGF8XY
        kgQovXM6UFgTM5cviH8yEQJHTONi1ZrIgpgRpsVxf5LTd0539deKXz9abAzjc4E9d2S77eaGYeajG
        45unRRtrv/POtJGyx7UrPxqiNnbh+RAu+VzvN1EJtJ0gIOiualt3Kq1A2gRMFlOk5jzCGNVAUIZIL
        OOfe0R2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnvN9-00DC3F-0A;
        Sun, 16 Apr 2023 05:56:23 +0000
Date:   Sat, 15 Apr 2023 22:56:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     William McVicker <willmcvicker@google.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        "Stephen E. Baker" <baker.stephen.e@gmail.com>,
        adilger.kernel@dilger.ca
Subject: Re: simplify ext4_sb_read_encoding regression
Message-ID: <ZDuOB8We29IAYR/4@infradead.org>
References: <YpNk4bQlRKmgDw8E@mit.edu>
 <CAFDdnB0a3mfcoY7rg5N4dO13qMeSsV+PkA2YHeerEOFRv8484Q@mail.gmail.com>
 <YpQixl+ljcC1VHNU@mit.edu>
 <CAFDdnB1WxrqddeLJwjsqqgoij1q_QGa=SBs-i=j31W2QbksJ=Q@mail.gmail.com>
 <YpVeeKRH1bycP7P1@mit.edu>
 <YpVxYchs1wScNRDw@mit.edu>
 <CAFDdnB1KJVSXXzXKOc+T+g1Qewr11AS4f9tFJqSMLvfpiX-5Lg@mail.gmail.com>
 <YpjNf8WGfYh31F+2@mit.edu>
 <ZDnbW1qYmBLycefL@google.com>
 <20230416054742.GA5427@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416054742.GA5427@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Apr 16, 2023 at 07:47:42AM +0200, Christoph Hellwig wrote:
> We could do that, but it seems a bit ugly.  What prevents symbol_request
> from working properly for this case in your setup?

To anwer to myself - I guess we need something else than a plain
EXPORT_SYMBOL for everything that is used by
symbol_request.  Which would be a nice cleanly anyway - exports for
symbol_request aren't normal exports and should probably have a clear
marker just to stand out anyway.
