Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C34633C65A
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Mar 2021 20:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhCOTGd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Mar 2021 15:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhCOTGc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Mar 2021 15:06:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC75C06174A
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 12:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4CiZLIYw6bmdPB3ZMW7hHqURYy162uSVmUqoNibdWoc=; b=b1+uTYBprlx5trah0j0kHToSvW
        zPl4w9nIirskKi7m6g/vDTOjJe3SmRLrQW29VkczPte/bQleEQOaD3H4/RrNb25Jt3yk0q9DPwI6/
        1VAlgqZzG2mafuD6EPWFOp5gQZKgyMoCSR0Ls+vBDBHJtTXuL4AFJOHHAljgc1Ruxx+Zogq8TDM1r
        4lxHg4d3gDhQ6SxbDYYZYNTzvtCNaXscvLdP341c/irIeqbhd08kYO0MQmnyLyRHQBfmr3qCaTet2
        Zg1rNGBZGup+efJa20wIt1LMHYhAEc9GZVFVZzvunKY265v3QXS1x6DwbKIsrv/6Roj7cPlsOUVxH
        FGK50d+Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLsXi-000dR7-8Z; Mon, 15 Mar 2021 19:06:20 +0000
Date:   Mon, 15 Mar 2021 19:06:18 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v4 2/6] ext4: add ability to return parsed options from
 parse_options
Message-ID: <20210315190618.GA150808@infradead.org>
References: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
 <20210315173716.360726-3-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315173716.360726-3-harshadshirwadkar@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 15, 2021 at 10:37:12AM -0700, Harshad Shirwadkar wrote:
> Before this patch, the function parse_options() was returning
> journal_devnum and journal_ioprio variables to the caller. This patch
> generalizes that interface to allow parse_options to return any parsed
> options to return back to the caller. In this patch series, it gets
> used to capture the value of "mb_optimize_scan=%u" mount option.

Instead of adding more code to the legacy option parsing code can
someone convert ext4 to the new mount API first?
