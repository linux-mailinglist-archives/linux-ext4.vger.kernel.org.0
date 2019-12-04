Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 651DC112F08
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Dec 2019 16:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfLDPzY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Dec 2019 10:55:24 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:43440 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfLDPzY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Dec 2019 10:55:24 -0500
Received: by mail-lj1-f176.google.com with SMTP id a13so8667640ljm.10
        for <linux-ext4@vger.kernel.org>; Wed, 04 Dec 2019 07:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wk62nr6sbOubH5V981U5bO4DJZQBAJzhc3G8JnkhcXc=;
        b=dpvYNX1vc4sOsBjpwU9IS/ZDKlXUNagdF4ysbJ/RDb2GyI2GGnkGQzSJ0yOXjBD43I
         Y3pS4licyZea9QXxVa+f4vDBKKKCVtz8KKa43rp3sIThqOIfZnp9gCBs1qrUGAFcdOnW
         yhQW6FudRKNtFcYJvSJYRdBbccw+3DbkXp7Ia2++GCXyJt0MlLbB71ZI8WDKR6kvfAzh
         oc0FyJjadzsX4sBRykCx98C1Za//o/4g4Uv1uN3PYSw4DfMUSrd1fsNArRG9u94UB0Iq
         lNuFtdzPeGOnCqXo5c9q3qCCgJ9YD4x2d50ZVdtNkba/9uMZ1zL3qbLYegj7tWDbiMOV
         gAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wk62nr6sbOubH5V981U5bO4DJZQBAJzhc3G8JnkhcXc=;
        b=Z++CdyOqc0yct3sbZ358RBFlARGhpv5rjsenArVBZeXFz4WjbTqry/CXm/FZUlfTbv
         vYsrZofOlrDquLAfFqI9DLj9zillOR4dyA61qrlXiV8Os99t7zB+bIpQkpzXxvGPjYXK
         m1O1hXcXq94pnCnkjEDH8gxHnpTw0y+AywHRc8Pg/MUx71XLdhu1/0WgST1mYmjmAiHP
         gTYCpB36cZI1pB/B1n/TPXjzieR7t9H4zLeIdihU7qsCYISkfIfU3nd7gKrdrT0LN2SE
         jsA+UcHaGEVsjcsgrcVsddeEaDn+j7lZa1T5f78eVbur3oX0qNxHIpPAHz2SGFBiGwWJ
         l4Rw==
X-Gm-Message-State: APjAAAWPwaDw4y7ZfLHgcifsqdQlgRViIdjX/H/MMzbm/d/qWgk1kCp1
        tbvOs4yrMzb3L586JHNu1veqNGuLb2CFUQdz
X-Google-Smtp-Source: APXvYqxhqLtPOowpum4KN4g7ig/X0+ftjB1WE0M/T4ebVegWv8K4yETmgOmPjz6PG5wwpZ224NeclQ==
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr2471914ljg.3.1575474922031;
        Wed, 04 Dec 2019 07:55:22 -0800 (PST)
Received: from msk1wst115n.omp.ru (mail.omprussia.ru. [5.134.221.218])
        by smtp.gmail.com with ESMTPSA id 22sm3829543ljw.9.2019.12.04.07.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 07:55:21 -0800 (PST)
Message-ID: <9ed62cfea37bfebfb76e378d482bd521c7403c1f.camel@dubeyko.com>
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
From:   Vyacheslav Dubeyko <slava@dubeyko.com>
To:     Daniel Phillips <daniel@phunq.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date:   Wed, 04 Dec 2019 18:55:20 +0300
In-Reply-To: <6b6242d9-f88b-824d-afe9-d42382a93b34@phunq.net>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
         <20191127142508.GB5143@mit.edu>
         <6b6242d9-f88b-824d-afe9-d42382a93b34@phunq.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, 2019-12-01 at 17:45 -0800, Daniel Phillips wrote:
> On 2019-11-27 6:25 a.m., Theodore Y. Ts'o wrote:
> > (3) It's not particularly well documented...
> 
> We regard that as an issue needing attention. Here is a pretty
> picture
> to get started:
> 
>    https://github.com/danielbot/Shardmap/wiki/Shardmap-media-format
> 
> This needs some explaining. The bottom part of the directory file is
> a simple linear range of directory blocks, with a freespace map block
> appearing once every 4K blocks or so. This freespace mapping needs a
> post of its own, it is somewhat subtle. This will be a couple of
> posts
> in the future.
> 
> The Shardmap index appears at a higher logical address, sufficiently
> far above the directory base to accommodate a reasonable number of
> record entry blocks below it. We try not to place the index at so
> high
> an address that the radix tree gets extra levels, slowing everything
> down.
> 
> When the index needs to be expanded, either because some shard
> exceeded
> a threshold number of entries, or the record entry blocks ran into
> the
> the bottom of the index, then a new index tier with more shards is
> created at a higher logical address. The lower index tier is not
> copied
> immediately to the upper tier, but rather, each shard is
> incrementally
> split when it hits the threshold because of an insert. This bounds
> the
> latency of any given insert to the time needed to split one shard,
> which
> we target nominally at less than one millisecond. Thus, Shardmap
> takes a
> modest step in the direction of real time response.
> 
> Each index tier is just a simple array of shards, each of which fills
> up with 8 byte entries from bottom to top. The count of entries in
> each
> shard is stored separately in a table just below the shard array. So
> at
> shard load time, we can determine rapidly from the count table which
> tier a given shard belongs to. There are other advantages to breaking
> the shard counts out separately having to do with the persistent
> memory
> version of Shardmap, interesting details that I will leave for later.
> 
> When all lower tier shards have been deleted, the lower tier may be
> overwritten by the expanding record entry block region. In practice,
> a Shardmap file normally has just one tier most of the time, the
> other
> tier existing only long enough to complete the incremental expansion
> of the shard table, insert by insert.
> 
> There is a small header in the lowest record entry block, giving the
> positions of the one or two index tiers, count of entry blocks, and
> various tuning parameters such as maximum shard size and average
> depth
> of cache hash collision lists.
> 
> That is it for media format. Very simple, is it not? My next post
> will explain the Shardmap directory block format, with a focus on
> deficiencies of the traditional Ext2 format that were addressed.
> 

I've tried to take a look into the source code. And it was not easy
try. :) I expected to have the bird-fly understanding from shardmap.h
file. My expectation was to find the initial set of structure
declarations with the good comments. But, frankly speaking, it's very
complicated path for the concept understanding. Even from C++ point of
view, the class declarations look very complicated if there are mixing
of fields with methods declarations. It's tough to read such
implementation.

So, I believe it makes sense to declare the necessary set of structures
in the file's beginning with the good comments. Even it will be good to
split the structure declarations and methods in different files. I
believe it will ease the way to understand the concept. Otherwise, it
will be tough to review such code.

Thanks,
Viacheslav Dubeyko.


