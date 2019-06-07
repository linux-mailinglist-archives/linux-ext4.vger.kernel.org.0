Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD02383B5
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jun 2019 07:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfFGFXf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jun 2019 01:23:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGFXe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jun 2019 01:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8gwVcPBOqZoElfdq0fiOMMWmCaPefT+J6uFG3oqbogk=; b=drGkQVRDz4WtdrT/e6bkznhdi
        6M+zvH9eRHIsR3LbS6zXalYmSh5ZglK8SP6zGlVLuTh83Pr++E3ER9wDXyo4UbGCIdr3j5iUpuM7E
        WhKsTQHCg3QzbsrC8csu1FvEWu8uZP/3DIlBhrpQzSMB3quoU0iq0eOEMkP6DYikviv3Op0KoCFj2
        ei7215WH0vnOodNiYJZN/wEziBhqmKJF5OnsnJaohldu9cewHIr/4C+reb5JaII6tl003dZhPfl6R
        796yKkB2cbqjlpsd1FXEkiUleMERO2htpcTdHU/NMfbntv9Ou9xXHMQwZoZTkkY7TpH+ZwD7GD0ww
        zyPYFqvbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hZ7Lf-0006fM-U0; Fri, 07 Jun 2019 05:23:31 +0000
Date:   Thu, 6 Jun 2019 22:23:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: [PATCH v2 2/2] ext4/036: Add tests for filename casefolding
 feature
Message-ID: <20190607052331.GA19838@infradead.org>
References: <20190606193138.25852-1-krisman@collabora.com>
 <20190606193138.25852-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606193138.25852-2-krisman@collabora.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 06, 2019 at 03:31:38PM -0400, Gabriel Krisman Bertazi wrote:
> From: "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
> 
> This new test implements verification for the per-directory
> case-insensitive feature, as supported in the reference implementation
> in Ext4.  Currently, this test only supports Ext4, but the plan is to
> run it in other filesystems, once they support the feature.
> 
> For now, let it live in ext4 and we move to shared/ or generic/ when
> other filesystems supporting this feature start to pop up.

Please keep it in shared/ from the start.  There isn't really anything
ext4 specific.  In fact xfs already supports CI file systems, just
without utf8 tables for now.
