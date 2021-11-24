Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F85445B21F
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Nov 2021 03:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhKXCoJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Nov 2021 21:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhKXCoJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Nov 2021 21:44:09 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1655C061714
        for <linux-ext4@vger.kernel.org>; Tue, 23 Nov 2021 18:40:58 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g18so1194876pfk.5
        for <linux-ext4@vger.kernel.org>; Tue, 23 Nov 2021 18:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XY5RlfJ4wk969SAhdu0eeba/cRDcEGFX6BIC3EnLQt8=;
        b=u4emMr/x1DnGrylyXG/XED1B0JAzKJIqIDcJvC7Dltb93SI0bgLALNc/xx3fE/eqZ+
         JLZdSBXcBeUsE3gYFy2qkeo6t2y2XuFS7FedCduv1RHpO8vyWXlQcx11qWzGXljZ4Nta
         5OYO1lIxqTIseUFqkypGfAJj577OlmYBnt7dfkNQv9WXesT9Vr2pO7qsjUMO6hVcoGvW
         LWz11ROd5H62YcZRNEwDlvUMRryoYOk1DV1Dg4YBgp+MSllvRl7B5PMc3nehblVandHp
         KDygLbglHM1zSoblBzsW1nhsjCF5iPULo9A3DjLMb5w2hx0fDJrK0R8dTmPxHRAXcCgM
         L96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XY5RlfJ4wk969SAhdu0eeba/cRDcEGFX6BIC3EnLQt8=;
        b=6OVG2/0jQPdoX/puNoIkPaGfyvnuf4gvE9NUMGtkzMbMBQQLB+b7w9aCnfvNYN+jAn
         MdZGuXN+JR5wL+RfOTHh8zjpTUn6dmLuoipOuzxeY7B0eSC7fwoteKIY7B0MAKEij3q2
         UQOlTv5tBuL2Noyh6oHLs3ydhPVN3CsQMI5VJyzzYVLFFtaZHgVHOF3k1vmmfgq33u07
         FNuIIg4XMKO0lKTpTTPqJUqlr+Z09qOrKxgZtzwC9Lmb/hRh5Ajcl9u7OIBkmsVmU6Wm
         opbeTzgXC6ZU1rGqgVz+5B+LIzkcjDsoj1B0b3WD2z6ls7Qmh7S1GBv6FQ4Rci7U0po6
         MIYQ==
X-Gm-Message-State: AOAM531LkNeqVWP6kSz44YOE6ombUQYk6mPsba3Op8rjmZ/bQyBtNruI
        8TqNRKAd36qgYO+Uf2LtGR4WdDjz7baY/Qq4MjItZQ==
X-Google-Smtp-Source: ABdhPJzf7x9CNNO+bnTL7ccWPdJMGj5rcrJdH+gi4z67GahFamuGnCABtN5RCIhrCvjUMVb9BfOrAHDXXr0x3X1l1Pc=
X-Received: by 2002:a63:88c3:: with SMTP id l186mr1768633pgd.377.1637721658407;
 Tue, 23 Nov 2021 18:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-22-hch@lst.de>
In-Reply-To: <20211109083309.584081-22-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 18:40:47 -0800
Message-ID: <CAPcyv4hY4g82PrjMPO=1kiM5sL=3=yR66r6LeG8RS3Ha2k1eUw@mail.gmail.com>
Subject: Re: [PATCH 21/29] xfs: move dax device handling into xfs_{alloc,free}_buftarg
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hide the DAX device lookup from the xfs_super.c code.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

That's an interesting spelling of "Signed-off-by", but patch looks
good to me too. I would have expected a robot to complain about
missing sign-off?

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
