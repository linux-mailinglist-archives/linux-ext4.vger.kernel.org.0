Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE11D0AD5
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2019 11:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfJIJSj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Oct 2019 05:18:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40495 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfJIJSj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Oct 2019 05:18:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so1222732pfb.7
        for <linux-ext4@vger.kernel.org>; Wed, 09 Oct 2019 02:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dIMjgz2wkdOJUmFipmSdwtOA8NXSDN4ksobQ1Cu2hUA=;
        b=QH1PLZwggPZx3KtHORU9BFAiQwvFEibddbWy92hdfzkazAoK0ZRupqHaNi8+5J36OJ
         zP6038H7xR7gzG+jDff1hyaTp1CfcrtC+tsqwU7G0ifDfhuxrQguMX5vTqFwStKCeBiq
         NEyXvdnNeCOHyirKwJW1TZmZtt/wOeTngrkeCjHi5/xtBgwFjj6pwGptTzNKpd0/CLOt
         EmRbcL+dBJzZDfWeH8ki/Tw+8z6UN1/mJIAvc4YHJERfcLGIJwbzALFAZe3VH+S3Zq4X
         ENC1o4zhJM2+RRQqWQwm7eyb/0ZRCeUnusjirW/3aMTvwiFwuP6zXbnRlIFaGzN1/nae
         b8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dIMjgz2wkdOJUmFipmSdwtOA8NXSDN4ksobQ1Cu2hUA=;
        b=N8Um4L7ycoZ6lkr6C/C9ex6/SzuG+xc3luZPcX8qOGabt+QJZc/T6b2zti6YHoikLp
         DP9HFyoLhqoPlVNO+KJgSo5GHk+FmEN4MpDScR/NiJQACY4DJ3zpdQo7keMB0tXhHhBj
         4JBG7dwkqUxfLZoHiDcTlsLRqcHSkNjkIdWJar2w5rS/hNcGLsfoUVT2IbemgBV1nMAB
         QsR6G0+nRBRLc3FRebAeqNh6aahuWZjEQVkRSon0dbSPwH+97je9y8Mu+TlL9q5Pui+g
         83CfR9HSv5HV52UhJLvFs3FwjQUJdqusl1t2qC4I7km5npSTLfVt1NwTMFhYqWzKqGGg
         izWw==
X-Gm-Message-State: APjAAAUoc5x2uaj008FRSt1QcEvGsUMSLSfs52clZLWwMtoZysCvc7hn
        xyrVXegQrn3XSNxV2QO/0fAv0ZUKa2JD
X-Google-Smtp-Source: APXvYqwmoyEVscGNMXHMxoyorGGNSGPQexKQNKFX+pBChZ4yWHcpoI8Ert7PG67/T1PhyKZrreUROw==
X-Received: by 2002:a62:283:: with SMTP id 125mr2684628pfc.137.1570612718047;
        Wed, 09 Oct 2019 02:18:38 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id h8sm2027979pfo.64.2019.10.09.02.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 02:18:37 -0700 (PDT)
Date:   Wed, 9 Oct 2019 20:18:31 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 2/8] ext4: move out IOMAP_WRITE path into separate
 helper
Message-ID: <20191009091830.GC2125@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <99b317af0f20a170fba2e70695d7cca1597fb19a.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008103137.GE5078@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008103137.GE5078@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 08, 2019 at 12:31:37PM +0200, Jan Kara wrote:
> On Thu 03-10-19 21:33:29, Matthew Bobrowski wrote:
> > In preparation for porting across the direct I/O path to iomap, split
> > out the IOMAP_WRITE logic into a separate helper. This way, we don't
> > need to clutter the ext4_iomap_begin() callback.
> > 
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> 
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Just please reformat the comments to use full 80 column lines. Your Emacs
> still doesn't seem to get it :)

*nod* :)

--<M>--
