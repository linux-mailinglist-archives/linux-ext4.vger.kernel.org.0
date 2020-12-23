Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536BA2E20A8
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Dec 2020 20:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgLWTAb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Dec 2020 14:00:31 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55150 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgLWTAb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Dec 2020 14:00:31 -0500
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by linux.microsoft.com (Postfix) with ESMTPSA id D2C1620B7192
        for <linux-ext4@vger.kernel.org>; Wed, 23 Dec 2020 10:59:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D2C1620B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608749989;
        bh=uez43AilikOFn49QTk3YljQKFRrnWOt0q9CmBYD3XmE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MKlmln2xBwYUXFaGtiZ7i7L4JPkbh3bvLWcZQKw80dX8d4e6RTTYovJRxo3EeQEUR
         QXf6Tr+yt9S0kqtDeNxjUNj9TG0/SLkyd3dyWSUbEOY+6Vhol40CGWstmCCcc1Jrbf
         DNN3YeU1IXPkBAAb9ZIF9WwIylSmbW7lDFv5awuo=
Received: by mail-pf1-f170.google.com with SMTP id t8so10872445pfg.8
        for <linux-ext4@vger.kernel.org>; Wed, 23 Dec 2020 10:59:49 -0800 (PST)
X-Gm-Message-State: AOAM531DncSp3FVeq/nFbyRD73EywU/iIJ8aio/grtDqnbVh/Sdl7bfB
        lNPp6QjRn7rhu9KN4Kdwyib1EehVnFzCaUFPBzw=
X-Google-Smtp-Source: ABdhPJzpFCbSbti2eUzrfVIN2MmxdmzDbnYr4dZ7sWimryaQMSpNjdIkg1+BPk1FbcGBEA6cDs7wqxzAy15x7YFaKKs=
X-Received: by 2002:a63:ca0a:: with SMTP id n10mr26005255pgi.326.1608749989346;
 Wed, 23 Dec 2020 10:59:49 -0800 (PST)
MIME-Version: 1.0
References: <CAFnufp2zSthSbrOQ5JE6rKEANeFqvunCR3W5Bx2VgN_Q3NbLVg@mail.gmail.com>
 <X+AQxkC9MbuxNVRm@mit.edu> <CAFnufp1N-k+MWWsC0G1EhGvzRjiQn3G8qPw=6uqE1wjwnPgmqA@mail.gmail.com>
 <X+If/kAwiaMdaBtF@mit.edu> <CAFnufp1X1B27Dfr_0DUaBNkKhSGmUjBAvPT+tMoQ8JW6b+q03w@mail.gmail.com>
 <X+OIiNOGKmbwITC3@mit.edu>
In-Reply-To: <X+OIiNOGKmbwITC3@mit.edu>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 23 Dec 2020 19:59:13 +0100
X-Gmail-Original-Message-ID: <CAFnufp3u66k5ucSRxxYwrcsPcJOGP25oxCfWFsrVRouQmDNyjA@mail.gmail.com>
Message-ID: <CAFnufp3u66k5ucSRxxYwrcsPcJOGP25oxCfWFsrVRouQmDNyjA@mail.gmail.com>
Subject: Re: discard and data=writeback
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 23, 2020 at 7:12 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Dec 23, 2020 at 01:47:33AM +0100, Matteo Croce wrote:
> > As an extra test I extracted the archive with data=ordered, remounted
> > with data=writeback and timed the rm -rf and viceversa.
> > The mount option is the one that counts, the one using during
> > extraction doesn't matter.
>
> Hmm... that's really surprising.  At this point, the only thing I can
> suggest is to try using blktrace to see what's going on at the block
> layer when the I/O's and discard requests are being submitted.  If
> there are no dirty blocks in the page cache, I don't see how
> data=ordered vs data=writeback would make a difference to how mount -o
> discard processing would take place.
>

Hi,

these are the blktrace outputs for both journaling modes:

# dmesg |grep EXT4-fs |tail -1
[ 1594.829833] EXT4-fs (nvme0n1p1): mounted filesystem with ordered
data mode. Opts: data=ordered,discard
# blktrace /dev/nvme0n1 & sleep 1 ; time rm -rf /media/linux-5.10/ ; kill $!
[1] 3032

real    0m1.328s
user    0m0.063s
sys     0m1.231s
# === nvme0n1 ===
  CPU  0:                    0 events,        0 KiB data
  CPU  1:                    0 events,        0 KiB data
  CPU  2:                    0 events,        0 KiB data
  CPU  3:                 1461 events,       69 KiB data
  CPU  4:                    1 events,        1 KiB data
  CPU  5:                    0 events,        0 KiB data
  CPU  6:                    0 events,        0 KiB data
  CPU  7:                    0 events,        0 KiB data
  Total:                  1462 events (dropped 0),       69 KiB data


# dmesg |grep EXT4-fs |tail -1
[ 1734.837651] EXT4-fs (nvme0n1p1): mounted filesystem with writeback
data mode. Opts: data=writeback,discard
# blktrace /dev/nvme0n1 & sleep 1 ; time rm -rf /media/linux-5.10/ ; kill $!
[1] 3069

real    1m30.273s
user    0m0.139s
sys     0m3.084s
# === nvme0n1 ===
  CPU  0:               133830 events,     6274 KiB data
  CPU  1:                21878 events,     1026 KiB data
  CPU  2:                46365 events,     2174 KiB data
  CPU  3:                98116 events,     4600 KiB data
  CPU  4:               290902 events,    13637 KiB data
  CPU  5:                10926 events,      513 KiB data
  CPU  6:                76861 events,     3603 KiB data
  CPU  7:                17855 events,      837 KiB data
  Total:                696733 events (dropped 0),    32660 KiB data

Cheers,
-- 
per aspera ad upstream
