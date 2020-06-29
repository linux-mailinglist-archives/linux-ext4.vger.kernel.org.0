Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C832220E274
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jun 2020 00:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390154AbgF2VFh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Jun 2020 17:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbgF2TMn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Jun 2020 15:12:43 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1A5C08EB17;
        Sun, 28 Jun 2020 23:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yvlilp1llFdU9iiu1LHhrhDDb73hODP2epRWqobx+Y4=; b=wECgs7mPEMM1puAOoGYHZMcv/6
        q/0yIsE6zm4ShN1TEwOCZUBtvAAaASgy5BH1adghPpwbFiLG78OjV1w129/fsykKJutsK3vMzsjAt
        cBEUmvQRdE0UP86U0TU/qrpJ3LTtlECtpFHoQ9kf3y4fgLwHf4M7XvyETn46Ltaz+2+tdtzB9Pn2G
        0tyMFwRxtjQj3SmwoXwQqm/N0Xl9X/mF+y3MzIqxaH9GmmksFexTgbpl8UJIXxpPLQ3vQAL/sA34J
        SrDwBZK0kblyw3XHycL9ey+QTClsLX1x00M+mK7uPISadpR2yNh8zpiyTF6OtxH+QMD91S0cGrlgN
        JGl9pYyQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpnBQ-0002t3-W6; Mon, 29 Jun 2020 06:22:25 +0000
Date:   Mon, 29 Jun 2020 07:22:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiang Ying <jiangying8582@126.com>
Cc:     Markus.Elfring@web.de, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        wanglong19@meituan.com
Subject: Re: [PATCH v2] ext4: fix direct I/O read error
Message-ID: <20200629062224.GA10550@infradead.org>
References: <1593400165-114818-1-git-send-email-jiangying8582@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593400165-114818-1-git-send-email-jiangying8582@126.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Any chance you could add your reproducer to xfstests?

Thanks!
