Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C867D115009
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2019 12:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLFLsB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Dec 2019 06:48:01 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36628 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfLFLsB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Dec 2019 06:48:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id n12so5048283lfe.3
        for <linux-ext4@vger.kernel.org>; Fri, 06 Dec 2019 03:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hhh6mle6wsMeItwQwyNxvjvSqox2y1Yqv8ZKxxJv+Iw=;
        b=RMGuSUqj06dSTepAFuR1WkL9q19jLPZAoArLujv15uwTBIOtBi6sx8NTTykK9n2FOY
         Zd6tT/GI5bj2rEMXqOm/sKug7mIXpF0zstb4O2nDCNQgHC0WRLK4gH6wXb8zAHkL++rb
         oAGMaUCeXfvHbgH2hcAzGmI2+SPQ6uApwIdjUpAc+0tHE0YYzqlTC116wid7SWsQOfsa
         Amy+9pCh4nXp8NwawglEBVLaAWz6u4wCFk6zV9TjQG+WGAkHCuxkdAne0jJ5dU16JLTS
         SCc3vG+PBBoYk6AGIlTaBZZ4LXEL/bePW9RyD83peDaIvg5aMgv70iFqN//ghEdN3aj1
         vwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hhh6mle6wsMeItwQwyNxvjvSqox2y1Yqv8ZKxxJv+Iw=;
        b=mESqmy3uhfpERljoEQ8coddKHcooAkx20FmYK1afs8bjctw1bc5SABfy1q4XWGiC+Q
         5/WWR1X5CWrcNG4COlHIheSy17z0s4aAHWBe0+kZUw7F/Tu4BSdjFfdYaI8Zy62LMTTW
         vpV3RIOY796UwAsUT47QOCKgL60NVba5jE8Kq+TyGmW2uSy48rva4KrYs7qROkiuK81w
         UFatjs9FznKJTW/kv7Z8jZ53qQXTr0X6f578oT2+W0Sq7IuwIwvq7gsnevrvQ3iiubdd
         2Q8sfPkZ1OOdIyZeT7k1zKwnLAJ0eK12c0+TpMgaD7tF/DQqB5eqD57tGKiKPoyJeiJt
         EvKg==
X-Gm-Message-State: APjAAAWx3h0X62YJL9IBwqtj0KCTFiFzirgjRa/n1EAxme9+fUgEl2dd
        nPuZTi3wFoAW2Obg7hkYdOEB9Q==
X-Google-Smtp-Source: APXvYqwdyDdSV6H7InUMwrXsqETxr8BCo0cBubMkB4YL/A4l5qsksa/lNvUo3xTXRHSnLwl0uBVEgg==
X-Received: by 2002:ac2:52a5:: with SMTP id r5mr7905464lfm.19.1575632878888;
        Fri, 06 Dec 2019 03:47:58 -0800 (PST)
Received: from msk1wst115n.omp.ru (mail.omprussia.ru. [5.134.221.218])
        by smtp.gmail.com with ESMTPSA id z7sm5084034lfa.81.2019.12.06.03.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Dec 2019 03:47:58 -0800 (PST)
Message-ID: <37c9494c40998d23d0d68afaa5a7f942a23e8986.camel@dubeyko.com>
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
From:   Vyacheslav Dubeyko <slava@dubeyko.com>
To:     Daniel Phillips <daniel@phunq.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date:   Fri, 06 Dec 2019 14:47:57 +0300
In-Reply-To: <c61706fb-3534-72b9-c4ae-0f0972bc566b@phunq.net>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
         <20191127142508.GB5143@mit.edu>
         <6b6242d9-f88b-824d-afe9-d42382a93b34@phunq.net>
         <9ed62cfea37bfebfb76e378d482bd521c7403c1f.camel@dubeyko.com>
         <c61706fb-3534-72b9-c4ae-0f0972bc566b@phunq.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 2019-12-05 at 01:46 -0800, Daniel Phillips wrote:
> On 2019-12-04 7:55 a.m., Vyacheslav Dubeyko wrote:
> > > 

<snipped and reoredered>

> And here is a diagram of the Shardmap three level hashing scheme,
> which ties everything together:
> 
>    https://github.com/danielbot/Shardmap/wiki/Shardmap-hashing-scheme
> 
> This needs explanation. It is something new that you won't find in
> any
> textbook, this is the big reveal right here.
> 

This diagram is pretty good and provides the high-level view of the
whole scheme. But, maybe, it makes sense to show the granularity of
hash code. It looks like the low hash is the hash of a name. Am I
correct? But how the mid- and high- parts of the hash code are defined?
It looks like that cached shard stores LBAs of record entry blocks are
associated with the low hash values. But what does it mean that shard
is cached?

Here is a diagram of the cache structures, very simple:
> 
>    https://github.com/danielbot/Shardmap/wiki/Shardmap-cache-format
> 

This diagram is not easy to relate with the previous one. So, shard
table and shard array are the same entities or not? Or do you mean that
shard table is storeed on the volume but shard array is constructed in
memory?

>There is a diagram here:
> 
>    
> 
https://github.com/danielbot/Shardmap/wiki/Shardmap-record-block-format

I am slightly confused here. Does header be located at the bottom of
the record block? My understanding is that records grow from top of the
block down to the header direction. Am I correct? Why header is not
located at the top of the block with entry dictionary? Any special
purpose here?

Thanks,
Viacheslav Dubeyko.


