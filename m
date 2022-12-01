Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB9763F2C2
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 15:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiLAOZR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 09:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiLAOZQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 09:25:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9837515802
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 06:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CtFiSnzVOo9jBQI/juduz9ZR+9e3yydPNsrUWy6fHBM=; b=PLC14oUbPT3MvJDPFJGKvX0YW1
        cfnqDDFJg3khgw0VIv3eKweuR8BwRJQwngsejYupPNOStFP3oX8U6MxqyHmne5w9fyUpmYP1obUHh
        QWwJEaj/UK1OgCyUqYA4+FE78U/6W26s2chfGVsjlFkFrAtH7YalV+2aIVE/m4qIExxlEESeo6+9A
        zkmy2mymbcvosGkXPFV1Qzke82C4MsN3xIwVX7Aqy56TLltmNYHBm6696swoNPJ1qzCiBQDsPIVmW
        Rb3cKceGsg1ekUdDMvCHRpIMdiJHnEytolKt+MnGM4BKhburYQ9OAxHGrYhQnK9ZGGJZibF26g6hY
        uZGfc7zw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0kUv-007u7G-5J; Thu, 01 Dec 2022 14:25:09 +0000
Date:   Thu, 1 Dec 2022 06:25:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 9/9] ext4: Remove ordered data support from
 ext4_writepage()
Message-ID: <Y4i5RbPXa9U42xkK@infradead.org>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-9-jack@suse.cz>
 <20221201112152.slnmx3u6jh7bhww5@riteshh-domain>
 <20221201133619.cov6ntr2fuceqhjs@riteshh-domain>
 <20221201141144.rgosvsixfkcyagbc@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201141144.rgosvsixfkcyagbc@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 01, 2022 at 03:11:44PM +0100, Jan Kara wrote:
> Hum, right. It didn't trigger for me :). I'll see how to fix this.

Just stop wiring up ->writepage (except for journalled data mode).
