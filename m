Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B761BDA5E
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 13:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgD2LJy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Apr 2020 07:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbgD2LJx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Apr 2020 07:09:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0A0C03C1AD
        for <linux-ext4@vger.kernel.org>; Wed, 29 Apr 2020 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=azkwK7kCyzu9TJzT40ryl2Bq1YKytVIxT2fz6tK4FSQ=; b=iQruzPw7Gr5yYsSt+fpH0L5ei8
        uQQrBpjQfk+OxabFAwwQ0f0jGDcfHEHpLJg8NbfsRvVK+IXQLUR8nE2jQdJsOrdKk99fmQU2u7r87
        d/LwUrqTKS8O+VtmCZWRw7L1ciRVv6GP9cHb5V94aIaFIvr7+2qgvH2HSQQ1z+5eK+utdCu6lwJrj
        p8lipLzrZyHt/2wzb1EQkSeC1TNTyOhZulkMYIAV/Z5KjjsivxzaPjHcnZQZHUYmeCF0wpLZV9KwR
        YpR6tT1Ynq+tVLGAzUxx2s/GEW1BVndVL1FkHABMYS7tjhw/QUw49XvbLaKsejNE7yMOvNA8wdAYD
        tcuVSXOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTkb5-0002Rp-Rr; Wed, 29 Apr 2020 11:09:47 +0000
Date:   Wed, 29 Apr 2020 04:09:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-ext4@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 05/17] ext4: Allow sb to be NULL in ext4_msg()
Message-ID: <20200429110947.GA6290@infradead.org>
References: <20200428164536.462-1-lczerner@redhat.com>
 <20200428164536.462-6-lczerner@redhat.com>
 <20200428164808.GA3632@infradead.org>
 <20200428165747.ondq7nbn4ol3j3lu@work>
 <4f6598e12127cc6e80af7dde5149220d92b07b11.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f6598e12127cc6e80af7dde5149220d92b07b11.camel@themaw.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 29, 2020 at 10:53:00AM +0800, Ian Kent wrote:
> The mount-API log macros tend to cause user confusion because they
> often lead to unexpected log messages.
> 
> We're seeing that now with bugs logged due to unexpected messages
> resulting from the NFS mount-API conversion.
> 
> I'd recommend mostly avoiding using the macros until there's been
> time to reconsider how they should work, after all fsopen() and
> friends will still get errno errors just not the passed string
> description.

And when is that time going to be?  Should we convert existing users
back and remove that functionality if it doesn't work properly?
