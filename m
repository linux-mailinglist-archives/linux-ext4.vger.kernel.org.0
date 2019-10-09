Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7999CD0CEB
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2019 12:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfJIKjq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Oct 2019 06:39:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36992 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfJIKjq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Oct 2019 06:39:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id u20so865066plq.4
        for <linux-ext4@vger.kernel.org>; Wed, 09 Oct 2019 03:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l2iX8XelpbvqMiP2lxIuWsuTbSoIGNGBULpyGQfwuWo=;
        b=iPMU4rrMThH8TMZDqFkrtFr5BUdjzbx5x2PeHuZRuzNT6m0bdgl0SDlSupx2+4+xNk
         4ow0YfJ9tr18QSD9/HxWgfYC4CdtA/pslKyyN1QeRwKDXHivhHsS0caPDA+FX7Z6CtHA
         pXm73FEZu9syAzidEpVHMTcszOcbPHZLpEAF1yFhwTuuo1rH8oU+HK73dxzi5gRElwv7
         CRI/i1QNWYL0brtKOQD/61azOc3xxPeuOMLM/UXCtevIjI4Z6cpmg59igWKX8AQCMSPO
         XSEPk9nl38UbV6wJU0011rdh3+ANRNTEusVmuG3nHVWSyhu6/wkv2Q//UvXxfAF7eu4R
         7Zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l2iX8XelpbvqMiP2lxIuWsuTbSoIGNGBULpyGQfwuWo=;
        b=cuMw/440JcDvclLcAMaEmHXTsTRTn5iOvqwKIngGzb7CeZwEqzL1kGk4CkhOuJksn/
         fi6C96UL3lWARF5A25HMCJUioeUqay37pWQEem1HlZ2jQhvytbeFC/TJ3l80ws8TQC9O
         vtGhh4n1dmN70h2m1xKOUjVhUEnfEGMmGFKJcxJ9FG0ArUUzdV7KlrJaV9oGkCbW2JA8
         R3zS/K4WI6rCO/wjqQdgMebg6OPWVPCC39EjnkDGg3X7ZTTYtZaGHjl6DGRma+cQmAq6
         2tFLwEVeaEljfoUIwU8qbapvs+3RZcXQBXp8S2reqcxT72/f8wAVWzsbvES6ZzTkdiDT
         +uVQ==
X-Gm-Message-State: APjAAAU9AR0n+Unh0ZHg99K6pSOjE1LHuyK9iiS0ELdcADE0OY8qxMjs
        5nz68ZjA0t33n0FxhyIx6hVT
X-Google-Smtp-Source: APXvYqyFsxjyWLWkxY7VG6zRxG7Uh5X2/DF1rnKCwE4x3SUkPhz/UXvUsh25uem7IvZt29g7izle2w==
X-Received: by 2002:a17:902:a717:: with SMTP id w23mr2484798plq.27.1570617584267;
        Wed, 09 Oct 2019 03:39:44 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id w14sm4734445pge.56.2019.10.09.03.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:39:43 -0700 (PDT)
Date:   Wed, 9 Oct 2019 21:39:37 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 6/8] ext4: move inode extension checks out from
 ext4_iomap_alloc()
Message-ID: <20191009103935.GC14749@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <d1ca9cc472175760ef629fb66a88f0c9b0625052.1570100361.git.mbobrowski@mbobrowski.org>
 <20191009063023.E332942047@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009063023.E332942047@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 09, 2019 at 12:00:22PM +0530, Ritesh Harjani wrote:
> On 10/3/19 5:04 PM, Matthew Bobrowski wrote:
> This looks good. Should solve our previous lengthy discussion
> about orphan handling :)

Yeah, although I'm still not the biggest fan of this approach.

> You may add:
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks Ritesh!

--<M>--
