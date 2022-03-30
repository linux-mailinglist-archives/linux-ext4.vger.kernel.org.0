Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBE64ECED9
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Mar 2022 23:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbiC3VbA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Mar 2022 17:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiC3Va7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Mar 2022 17:30:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9585201AC;
        Wed, 30 Mar 2022 14:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zg8QPhUnRt/Hkzrm5cK28VQZtjF5KNBpCqCGW4kGEzU=; b=gp2AC7YFCqYvCrXLC6M96E8zJ/
        wdbCazu0QWFmo2yWhiwDbt3O0LjagGcn4IuiW3kKlxDkIAICH5QTHAPGTzAm5iufn2OXW7f6V7uUC
        ovTtJo90zGzlnzULvissA0T9mkrV+FgN3y5UukAnIkPA+2NW0mXIwC3z4AQSFzN7ArhKnHg2jrfLk
        5SmSXpGlRFRJA448QClwxbyejE3sJeyc7xXl+PwT+mdAJz5h4qSdzSF9Z0D4C0yzyyTUFpUsuFQnE
        HoorQOmrMhmn0sA8AKOlwOZznwnrRNuDhI/FZv1otAO07OJQgnEpqYVTBdF0wrcNLrRpqol7lcMAb
        TfMfNV/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZfsH-001ah9-Na; Wed, 30 Mar 2022 21:29:05 +0000
Date:   Wed, 30 Mar 2022 22:29:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     jgg@nvidia.com, david@redhat.com, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH] drm/amdkfd: Add SVM API support capability bits
Message-ID: <YkTLoQNBEOlkJ1tV@casper.infradead.org>
References: <20220330212420.12003-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330212420.12003-1-alex.sierra@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 30, 2022 at 04:24:20PM -0500, Alex Sierra wrote:
> From: Philip Yang <Philip.Yang@amd.com>
> 
> SVMAPISupported property added to HSA_CAPABILITY, the value match
> HSA_CAPABILITY defined in Thunk spec:
> 
> SVMAPISupported: it will not be supported on older kernels that don't
> have HMM or on systems with GFXv8 or older GPUs without support for
> 48-bit virtual addresses.
> 
> CoherentHostAccess property added to HSA_MEMORYPROPERTY, the value match
> HSA_MEMORYPROPERTY defined in Thunk spec:
> 
> CoherentHostAccess: whether or not device memory can be coherently
> accessed by the host CPU.

Could you translate this commit message into English?  Reviewing
Documentation/process/5.Posting.rst might be helpful.
