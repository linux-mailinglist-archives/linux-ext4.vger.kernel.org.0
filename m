Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC7B1BC5B0
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgD1QsJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgD1QsI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Apr 2020 12:48:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C433BC03C1AB
        for <linux-ext4@vger.kernel.org>; Tue, 28 Apr 2020 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mOc/rqjmnYu1udu600jsrqq/4WNi8OKKxTrPBFh4Sts=; b=J2AljRHlOc9nekrumLtoEqNil+
        HRAfNuHC8RAArdvdGtAWPCwxv0dHfWvFq15y4vn+dg2r17Gb6z69aQGtitNTm8seyCfj3f2eaghi0
        sLIISEg+ChQNpwx2M7NonqeMCx6EMSDg3eVp+Jh7MiWtiNp9pJc2F6N8/+KbFpPqKzXA/ys2aE182
        csNxncniTTFJToKtxiZHRhX+iTgt6u0VaV6xnMpmft/i647+pIYZVm6Jdml5Rg76aGcHluv3mrucE
        pz/evlF9FE2v9EEMJcWT+kCXmTpcEky8WAmlv2cCTFJDx8ENQe63neWWv1JTbcWIgK1BePk27jRKH
        Z3oGlkeg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTTOy-0003T8-LO; Tue, 28 Apr 2020 16:48:08 +0000
Date:   Tue, 28 Apr 2020 09:48:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 05/17] ext4: Allow sb to be NULL in ext4_msg()
Message-ID: <20200428164808.GA3632@infradead.org>
References: <20200428164536.462-1-lczerner@redhat.com>
 <20200428164536.462-6-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428164536.462-6-lczerner@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 28, 2020 at 06:45:24PM +0200, Lukas Czerner wrote:
> At the parsing phase of mount in the new mount api sb will not be
> available so allow sb to be NULL in ext4_msg and use that in
> handle_mount_opt().
> 
> Also change return value to appropriate -EINVAL where needed.

Shouldn't mount-time messages be reported using the logfc and family
helpers from include/linux/fs_context.h? (which btw, have really
horrible over-generic names).
