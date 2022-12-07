Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61149645987
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 13:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiLGMAJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 07:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiLGL7z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:59:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2609C326CD
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 03:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=y1plqPieEfh+gP2sATLXjLTfVB
        iaTLiEaDpZZhpbnhU+IMRlGyYkxp5xxgMQLlJONZ5vfAnE96kDgZSWcrlDkPg0CZTGhRPdwxyyw4G
        GZ6nYoCV1+dRj2xv52ObU0Uj/ltIsPQE0yCex9HFHPQ43sblxJbgGvMOWdNQaoqGpa9hCi19eDpaZ
        r3MVziSSwscZWvV9d9Uxla/r3mSsBEGB2I43/q1NK7ZAnEe5/ewYuMhM5Jo/fNiO6xT28GiTs52pl
        eflDM6kh7QiQWFCK9fz1O9PU0y1eM+r4ZWI+US0e8RD4Bgq14ZLHFFX/E5jOviFgGvhJOVZ4ksr2s
        /XP7/arg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2t52-001o4j-8T; Wed, 07 Dec 2022 11:59:16 +0000
Date:   Wed, 7 Dec 2022 03:59:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH v4 11/13] mm: Export buffer_migrate_folio_norefs()
Message-ID: <Y5CAFN+Re2I1fBib@infradead.org>
References: <20221207112259.8143-1-jack@suse.cz>
 <20221207112722.22220-11-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207112722.22220-11-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
