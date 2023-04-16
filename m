Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708B46E3BC0
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Apr 2023 21:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjDPT6R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 15:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDPT6Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 15:58:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03781FE9
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F8t0fLT1mTjxrrVAfj8n0ln1c+IFX/6niWHfAypT1bg=; b=I7XAkSTX/+kQW+hXkkJx2khXGS
        TS04xTsEKyXyQsLpNlBGye1M8mqSHEgY1F43rg/IrCV7Ju7njvHm9zKH/ON59Nyc1BdPC+2VwXnhk
        I4WkaJto1T19ayG5s2qWRKjHG1MgMXaTBxUipOPahviyeWwI0y0G4ZIustClJZyxG5+FgZD00JWmN
        rMNdep7wE/u+m5p0ID4/OqHmam9Yk0ThNXf+XwMJInvl66IkaHvQLZaAw8h3VSjlQtTHtl+M17/ui
        E9+Is6xHRXWzJlHAjarhR3fKJCOPqXWOdxziCg/nhCX82TyNRp6fjvxyQZXixpOstvEJJTzi05xvX
        zrz5PjaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1po8Vp-00Acx1-EG; Sun, 16 Apr 2023 19:58:13 +0000
Date:   Sun, 16 Apr 2023 20:58:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv1 4/4] ext4: Make ext4_write_inline_data_end() use folio
Message-ID: <ZDxTVevCkxGJAtbE@casper.infradead.org>
References: <cover.1681669004.git.ritesh.list@gmail.com>
 <fb2cc9faae28d1abb2694c54fb49122cb0368e9c.1681669004.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb2cc9faae28d1abb2694c54fb49122cb0368e9c.1681669004.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 17, 2023 at 12:01:53AM +0530, Ritesh Harjani (IBM) wrote:
> ext4_write_inline_data_end() is completely converted to work with folio.
> Also all callers of ext4_write_inline_data_end() already works on folio
> except ext4_da_write_end(). Mostly for consistency and saving few
> instructions maybe, this patch just converts ext4_da_write_end() to work
> with folio which makes the last caller of ext4_write_inline_data_end()
> also converted to work with folio.
> We then make ext4_write_inline_data_end() take folio instead of page.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
