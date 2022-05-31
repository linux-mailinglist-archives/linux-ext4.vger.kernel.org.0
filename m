Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA45389F7
	for <lists+linux-ext4@lfdr.de>; Tue, 31 May 2022 04:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbiEaCjQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 May 2022 22:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiEaCjP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 May 2022 22:39:15 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41F96128D
        for <linux-ext4@vger.kernel.org>; Mon, 30 May 2022 19:39:14 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id n2-20020a9d6f02000000b0060b22af84d4so8787863otq.1
        for <linux-ext4@vger.kernel.org>; Mon, 30 May 2022 19:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94IbJiC1MsvXUj+2UwkW+EDcrjbI1fMH/SMkkaFGXmM=;
        b=eIS+/OZGI5EdA6w2dvTPLVbGZ8XTC9GnFgxTV9vRtAwkMckfgWX3AXxuATrNU8t69m
         hnYYZRzzGr5zKxWUoV1f2mWIc8BbW+2wbJewz5I5t6KNBiaOiZci8e/V65jZIdKR0KX1
         UnHQ3ap+DwoKpFJqVJE3yAz+f55+mhUF83cdkuYLdxMIzPMAFgpn5xsi57bvWi1e9+4v
         Fg4ibkCBsXyhW4wE89ATFZgx/b12t0JkUtQF7aAUKM53lpvrpnUHJV7Z5pSxauR0WdMe
         LIOhbiZ7BLvNirddeKDyfWp6l1fya9VqEptlzm30lJ5y/oGZDzOJN4wy0t4QkdLbsanf
         31Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94IbJiC1MsvXUj+2UwkW+EDcrjbI1fMH/SMkkaFGXmM=;
        b=v50+xJN3/VuHJzb1VC9rZBUBx4DXITiCX37wwt+IDpz1XyI1i1DbiFSR7bbfKjpVwd
         0BU/pHlqiroRERYghLaTyY8SBPce48X6fXbqp2uXDWya92RHL40iLgaZZ8VakmUxTIWC
         xKKR9SQHaIQBCfIOO1w9HvkXXWawMF3pLDy+YeqKCqe51B9gZqV7qGbrxBDahCPZ+Ck6
         L9Pdk7YxIDGC6g5NmYGyHUAtUmQa9eYUQlW7cf7OGli2UklksYOZbmQA0teEn9bcWdAw
         34PMcFUGrZdIoAnIiuzE2/ztpDRvzk+b9MM+DrWbuUGu0pDMDSbjlyHi8sLVH/uyTmDt
         yoeQ==
X-Gm-Message-State: AOAM532FYM+xdIYymRv+WCR3x6flubrSiT6jo8PwjOIOZnghQWCqj3xt
        5/VlKN+xHcbitwSwDPyIOsSTBifytXU1tTn2DzBPKYxSlU+xtw==
X-Google-Smtp-Source: ABdhPJxHjE02iD+vIDSo/OJx42FMgWPm5CAIrAFEmSA+kJwS0KMX1biTTMjbRJtil+0/93oYYjdXW6EaRl6+63x9Zkg=
X-Received: by 2002:a9d:5387:0:b0:60b:9e65:c638 with SMTP id
 w7-20020a9d5387000000b0060b9e65c638mr755883otg.120.1653964754256; Mon, 30 May
 2022 19:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAFDdnB38yRcZ+mQButh9UwGoh928xsZCgmjQ7r3HPEpEwdrZbg@mail.gmail.com>
 <87sfor85j1.fsf@collabora.com> <CAFDdnB3U67YJ7pivdHQaMB-CkdmvvTbcpxp1FXxBmFyAgJPknw@mail.gmail.com>
 <20220531005646.GS3923443@dread.disaster.area>
In-Reply-To: <20220531005646.GS3923443@dread.disaster.area>
From:   "Stephen E. Baker" <baker.stephen.e@gmail.com>
Date:   Mon, 30 May 2022 22:39:01 -0400
Message-ID: <CAFDdnB07-o6eXFma=iO5oeL6n5FGUur_g8S=AfktkTbpMybv+g@mail.gmail.com>
Subject: Re: simplify ext4_sb_read_encoding regression
To:     Dave Chinner <david@fromorbit.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 30, 2022 at 8:56 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, May 30, 2022 at 06:27:29PM -0400, Stephen E. Baker wrote:
> > I don't have any output to provide unfortunately. It fails before the
> > backlight turns on, and nothing is written to disk. I seem to remember
> > that someone else at Collabora had figured out a way to get a serial
> > console on this device - perhaps Tomeu. I'm not equipped for that
> > personally, particularly if it involves soldering.
>
> https://www.kernel.org/doc/html/latest/networking/netconsole.html
>
Thanks for the tip, it seems my usb ethernet card comes up a little too
late for netconsole; but if there was any way to adjust the boot order it
would work well. Alternatively, any other method of exporting printk
messages.

[    4.803080] netpoll: netconsole: local port 6665
[    4.808242] netpoll: netconsole: local IPv4 address 0.0.0.0
[    4.814476] netpoll: netconsole: interface 'eth0'
[    4.819728] netpoll: netconsole: remote port 6666
[    4.824988] netpoll: netconsole: remote IPv4 address 192.168.1.42
[    4.831794] netpoll: netconsole: remote ethernet address 00:30:67:53:8f:79
[    4.839593] netpoll: netconsole: eth0 doesn't exist, aborting
[    4.846023] netconsole: cleaning up
...
[    6.528582] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.536623] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks:
(500 GB/466 GiB)
[    6.546386] sd 0:0:0:0: [sda] Write Protect is off
[    6.551754] sd 0:0:0:0: [sda] Mode Sense: 37 00 00 08
[    6.554465] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    6.566947] sd 0:0:0:0: [sda] Optimal transfer size 33553920 bytes
[    6.632458]  sda: sda1 sda2
[    6.708529] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.724058] EXT4-fs (sda2): Using encoding defined by superblock:
utf8-12.1.0 with flags 0x0
[    6.733988] EXT4-fs (sda2): Using encoding defined by superblock:
utf8-12.1.0 with flags 0x0
[    6.743851] EXT4-fs (sda2): Using encoding defined by superblock:
utf8-12.1.0 with flags 0x0
[    6.800054] EXT4-fs (sda2): recovery complete
[    6.804967] EXT4-fs (sda2): mounted filesystem with ordered data
mode. Opts: (null). Quota mode: none.
[    6.815428] VFS: Mounted root (ext4 filesystem) on device 8:2.
...
[    7.045492] usb 8-1.4.1: New USB device found, idVendor=0bda,
idProduct=8153, bcdDevice=31.00
[    7.055094] usb 8-1.4.1: New USB device strings: Mfr=1, Product=2,
SerialNumber=6
[    7.063475] usb 8-1.4.1: Product: USB 10/100/1000 LAN
[    7.069193] usb 8-1.4.1: Manufacturer: Realtek
[    7.074266] usb 8-1.4.1: SerialNumber: 001000001
...
[    7.499107] r8152 8-1.4.1:1.0: load rtl8153b-2 v1 10/23/19 successfully
[    7.553995] r8152 8-1.4.1:1.0 eth0: v1.12.11
