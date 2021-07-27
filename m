Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5503D706F
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jul 2021 09:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhG0HdG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jul 2021 03:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhG0HdG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jul 2021 03:33:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6D3C061757
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jul 2021 00:33:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so2885328pjb.3
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jul 2021 00:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJ441JBu88Gh6BlC4YFSIsYeViFCgMPHq7UZlhYffEc=;
        b=U0FrzDh3U7zSwkZlQUp3g7eqCL2QlQ9wH5G7GuUefXeSSG6UEpGC8pebJM4Z3pzZ2z
         YY9JT3Xcl+buZaD67NwBJaFlGqA7h1XEdeI9I6QcTA8zmEjoCwINc1o9DdkyUJRmgeNf
         wiy7iwCgRNlAH40W9uH8MUf8uMhaHE+DCMYB+Vzo7ZM3mpRgo/K0224vhwvBOlzSMoaw
         t8xIsNxD62uCvviV+vZFshwPG+RDGZb7XU7axMyc2C5AmxNm3vsI05FtkpTJcM9slTS3
         1Dn23DsEQxyE5X3QZZIWcRSCDZ3Xh8oIEfj5k+vzIEGdYVttpgOuwYvhO0JEkaPPZkXH
         dQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJ441JBu88Gh6BlC4YFSIsYeViFCgMPHq7UZlhYffEc=;
        b=GjiyoFgKczaNayMNA8+tp68+k6PuzgK0bpzdfwXiJ9l550XB/EaMaVBmbD5PIlQGdH
         dTwm6tymGANV/1xq9KZkEizfP2VUY36y7FIsn1yMj/im+jvCz0cltkFs54zMGz4MIuTQ
         iaGgRL4eQSFJQJxiYtQ2TQ4wMpyB1/DcX1aF15V0jsMY4NhQFMkAZLCa+f5fjs+uOFvn
         66yzeKVvMxbLXKisqtxplwivRiMEI5gBOI3QbPMzF/eJFLI4REZldKLPtGSjJ0uKp0zJ
         9BkLxmWAw/0B28IVXNEP1fxSiyunUy+nhPT7GubP6WR6VAbKgYLHkwSywM7PPAvz5VhD
         HGjw==
X-Gm-Message-State: AOAM532UpQzkqb5g/hePRClffSJgqaGn/MmEYFl+gGnvdrcBoZp3+yFK
        NMhhxle84JmkCB5qiHDwWVcY4iN2dMzsHYCDJH+j6dCDpj5kpg==
X-Google-Smtp-Source: ABdhPJxJsamhAs91N8cqu449wJoh6XSD/71d+byuejnnx68Fzg8ND2VWHnXCcGsZB14DMxtR+I5YQe7iQrG+Phbnvlg=
X-Received: by 2002:a05:6a00:189d:b029:338:c077:ba11 with SMTP id
 x29-20020a056a00189db0290338c077ba11mr22264449pfh.21.1627371185160; Tue, 27
 Jul 2021 00:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAMU1PDgNvW_3Jr91iii-Nh=DCuRytVG8ka3-J+a43gKwigx8Yg@mail.gmail.com>
 <34ca4e40-2026-d48d-7181-fbea6ba4f140@thelounge.net>
In-Reply-To: <34ca4e40-2026-d48d-7181-fbea6ba4f140@thelounge.net>
From:   Mike Fleetwood <mike.fleetwood@googlemail.com>
Date:   Tue, 27 Jul 2021 08:32:53 +0100
Message-ID: <CAMU1PDgJAadK21H_-u3vg0NujKRzBegH0SHL2+54+23ZppFDgQ@mail.gmail.com>
Subject: Re: Is labelling a mounted ext2/3/4 file system safe and supported?
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 26 Jul 2021 at 21:50, Reindl Harald <h.reindl@thelounge.net> wrote:
> Am 26.07.21 um 20:45 schrieb Mike Fleetwood:
> > Hi,
> >
> > Using e2label to set a new label for a mounted ext4 seems to work, but
> > is it a safe and supported thing to do?
>
> it is

Is there some documentation which states it's safe to write to the label
while mounted?

I ask because 1) I am looking at adding such support into GParted and
2) I don't understand how it can be safe.

Looking at the e2label source code, it just reads the superblock,
updates the label and writes the super block.  How is that safe and
persistent when presumably the linux kernel has an in-memory copy of the
superblock will be written at unmount and presumable sync.

Thanks,
Mike
