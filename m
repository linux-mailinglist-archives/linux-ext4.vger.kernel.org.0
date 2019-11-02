Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE7CECD1C
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Nov 2019 05:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfKBEZ1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 2 Nov 2019 00:25:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43536 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfKBEZ1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 2 Nov 2019 00:25:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id b19so10100703otq.10
        for <linux-ext4@vger.kernel.org>; Fri, 01 Nov 2019 21:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVKY0SioYELJ6ImI8v503Lskf+dAkDXW4DKFTghrrvY=;
        b=SHWv2jkO49HDcZocXLDXy78sL6G9/hjS58JuJUxYvtdb3mk1EEucfKJPlTLckUhr/J
         YuA1vjvu+ra/1CvOsajcC5oiZ6IrRNsgwZQ4CefAkjgyaaVbYonwj6WcPQSTMaSlkFno
         To/RTYODLOo8jttLyd+bE/2HvuMZRYa8SdNFzoCAjPx3wr+fSElVFlgBs/kxYnMgxq1A
         +WiE9CcIUveR6MOhQHaTHl/UlIlugi9OMXaOxEkmYhIt32I/kYLnkgVpnYAroc7txWnC
         HHR7UqKp5Bkie3I1vmlt0T6AJ9ifxAINOBUt4n04sEG4cVQfzRSP5Dyq0Q7T2CGrGfA1
         OSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVKY0SioYELJ6ImI8v503Lskf+dAkDXW4DKFTghrrvY=;
        b=CTs/ci9LyxIJOg50MbgKfUT+n9wLR4QVYPka2sWpdam/PXlmGeLjtV1bt1uh/nxeoY
         sBj/tp/D1GjWvhV8a091GcR6RI8fAQiQxSE8FdquP4KQXXpf2B9hU2k2zEdz/TEvAOSZ
         1qjF0YX4CvnTIktG0vMYaM7oehtJGLgaL1Y2v3XmhOwwthfPBeUEkn2Vc1OMXKfCuN7e
         qkiSCh47Qera7RlaHYq1DQmeuL/NYzG0UfohXBGaWns//2z5lDzwaq659SfqfjWHKoa9
         j8IEeQQ8WgKqb6a88OwFSfAunp9+qe8G2haCmXQ2Oi/VCiNp7drRDb52f6yjgEyopT8F
         e24g==
X-Gm-Message-State: APjAAAXnt+0ecbIyrx4BHZiSUDL6yrQpNqSJf5LBCI9qxICqp0ekgJ00
        4IqajBJ6MZZy5wMS19aDgbZv1wCW6DlVjNldTtYNKw==
X-Google-Smtp-Source: APXvYqzuhvuy068R2WZlsZs6OALu7q7vZmg+l5pCz59QbwFS6qu8b/RiiqHO1Swr/2p2mNuDWmNLcgvs2qICNDvAVow=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr11067444otb.126.1572668726439;
 Fri, 01 Nov 2019 21:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191023221332.GE2044@dread.disaster.area> <efffc9e7-8948-a117-dc7f-e394e50606ab@plexistor.com>
 <20191024073446.GA4614@dread.disaster.area> <fb4f8be7-bca6-733a-7f16-ced6557f7108@plexistor.com>
 <20191024213508.GB4614@dread.disaster.area> <ab101f90-6ec1-7527-1859-5f6309640cfa@plexistor.com>
 <20191025003603.GE4614@dread.disaster.area> <20191025204926.GA26184@iweiny-DESK2.sc.intel.com>
 <20191027221039.GL4614@dread.disaster.area> <20191031161757.GA14771@iweiny-DESK2.sc.intel.com>
 <20191101224715.GY4614@dread.disaster.area>
In-Reply-To: <20191101224715.GY4614@dread.disaster.area>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 Nov 2019 21:25:15 -0700
Message-ID: <CAPcyv4juj9E1qKSXzOVfugmd=rBLZAvfbDdZT6ut0LdWwza=xA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Enable per-file/directory DAX operations
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Boaz Harrosh <boaz@plexistor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 1, 2019 at 3:47 PM Dave Chinner <david@fromorbit.com> wrote:
[..]
> No, the flag does not get turned on until we've solved the problems
> that resulted in us turning it off. We've gone over this mutliple
> times, and nobody has solved the issues that need solving - everyone
> seems to just hack around the issues rather than solving it
> properly. If we thought taking some kind of shortcut full of
> compromises and gotchas was the right solution, we would have never
> turned the flag off in the first place.

My fault. I thought the effective vs physical distinction was worth
taking an incremental step forward. Ira was continuing to look at the
a_ops issue in the meantime.
