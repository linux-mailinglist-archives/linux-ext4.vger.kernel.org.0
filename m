Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E03430A7F9
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Feb 2021 13:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhBAMuP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Feb 2021 07:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhBAMuL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Feb 2021 07:50:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B690DC061756;
        Mon,  1 Feb 2021 04:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LNMXZeM5uNb+EU3vYkiOU7VuaDzKzgxr27M0EWd1gXg=; b=JyPpTIciZcwyhSM4sv1gT1xEV2
        0z5MOVHELgFc0qrcjIaQX4bzHl1Wi7dZQmLiKoC8imC3qcxYclJklKVTIayFNz63cOLLwHbEU8Oti
        d6MR1ncZSCJIJsDTQMfP4x8hcpyiSzBCOVp/KnJ+kDaRefPDjkFooDF9dyKlVp5UTmG4FeQejTFYy
        lkdHwq02YeOVSj/tjUXn8I16CMPcV961S17C8ASRFYQLP4UGsskKQ2H8UgxgCbNfDv+pSOW1dWzlf
        VOBX+paVHKLedMFlmUFRH8Xe9rcyx+liKyVprM3it+gU+2rdfDOpHun7nL+46YBTDOO1Nj6qMfEzD
        3H7ZAyRQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6Ydw-00DmNX-SM; Mon, 01 Feb 2021 12:49:25 +0000
Date:   Mon, 1 Feb 2021 12:49:24 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Vinicius Tinti <viniciustinti@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
Message-ID: <20210201124924.GA3284018@infradead.org>
References: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
 <20210201003125.90257-1-viniciustinti@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201003125.90257-1-viniciustinti@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

DX_DEBUG is completely dead code, so either kill it off or make it an
actual CONFIG_* symbol through Kconfig if it seems useful.
