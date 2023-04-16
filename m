Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3310A6E3B9B
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Apr 2023 21:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDPTqO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 15:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDPTqO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 15:46:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C37F2694
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pKdRryQDAYZQhVZoYTFX0r/oEBnu6SJP+HDNDQPvnnc=; b=sKeK1t506Ic+urAt93I/lxi0RV
        tKJDvbjubfYpCfwjQPhkFzR8vt/MEzWSBckCgExDYFoflHVQ2+eZYyitdjH6cvMJBrflCXGLILf9Z
        e2bpm3wf6lbytwd+sWVyXJwmYdJnwhkMv/EloqHz5Jij+Tc359knBUDD/NockCEum+PktpxRz3I36
        CJJK8rbd5VrscD0pGE3kq2FrLctQYAlfcUj226XRvykJXpiisipTXnZuLBHuKHwPsWnNnJx1jT0FH
        1uCna3YoX5Pk+hJJgY2RnN8xIe+FAXDl+duYWqp/DlI9ZfV7bvpNrkQ01zU8hSmMBcVOO17alv63m
        hmqgVT1g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1po8KA-00AcMs-RP; Sun, 16 Apr 2023 19:46:10 +0000
Date:   Sun, 16 Apr 2023 20:46:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv1 3/4] ext4: Make mpage_journal_page_buffers use folio
Message-ID: <ZDxQghSIxhX+YUME@casper.infradead.org>
References: <cover.1681669004.git.ritesh.list@gmail.com>
 <9d0fe99d45e88fd0446df745c31b561fefab898e.1681669004.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0fe99d45e88fd0446df745c31b561fefab898e.1681669004.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 17, 2023 at 12:01:52AM +0530, Ritesh Harjani (IBM) wrote:
> This patch converts mpage_journal_page_buffers() to use folio and also
> removes the PAGE_SIZE assumption.

Bit of an oversight on my part.  I neglected to do this after Jan added
it.  Perils of parallel development ...

> -static int ext4_journal_page_buffers(handle_t *handle, struct page *page,
> -				     int len)
> +static int ext4_journal_page_buffers(handle_t *handle, struct folio *folio,
> +				     size_t len)

Should this be called ext4_journal_folio_buffers?

