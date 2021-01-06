Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310202EC5F6
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jan 2021 23:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbhAFWBn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Jan 2021 17:01:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbhAFWBn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 6 Jan 2021 17:01:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EF9623158;
        Wed,  6 Jan 2021 22:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609970462;
        bh=ZazHsqTKqsJUDCie17bXdpwHlHRAAz1v4c70H3q4lqk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ly5GtgrHsy6il4LntyHftNUbY9aoFZh6svdOZUNZiZyHltdzfhgIxeFrAfifbZB4t
         Wc4ssEDEsPZVIfQF+Lrvn/SJxv7Z2Ck7+xh7vVDlpqQRdYJ+yC+yRtoRK/ZnnI6u+p
         wx+FJyrZMqX5ThMk/Ob1vatMpU/+JZ0/jYzdZ6ZhmfL62WJxWUwzDpLVsADGP0I1GE
         nkpvK4Sil0jHe+vEe/VsRCxfahD4fFSI4dlTthgtRLxziw45cU4hjIx5GzmL0iqDrx
         AjuexBl+i7omd5Efxn26BQOeVDyuEIB0juLeoRQxSpLmghgDBmpNEHIJZ8qOLvGYMX
         5AMB4ec+KOSYg==
Received: by mail-oi1-f182.google.com with SMTP id s75so5163902oih.1;
        Wed, 06 Jan 2021 14:01:02 -0800 (PST)
X-Gm-Message-State: AOAM532D4Y65dbPRQWcbIlV2qYLMk9Xk0k1/hdFA0NwBpT+xditKfSk2
        YHJzMHP6QKjwHnvsapoHHhyXncg9FdGJRufD1eI=
X-Google-Smtp-Source: ABdhPJzsD+IQNIsYlmU0YXwX0XNNpnfomb1ESCqy+8vt1QJN7Mq1VoOvSovpvyKXA60WxMx07dXgXCbTiFA7CtO/NNQ=
X-Received: by 2002:aca:e103:: with SMTP id y3mr4410112oig.11.1609970461599;
 Wed, 06 Jan 2021 14:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20210105154726.GD1551@shell.armlinux.org.uk> <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk> <20210106172033.GA2165@willie-the-truck>
 <CAK8P3a2u=WtQ_98F2934QEZM19YaDPkfzQzHoiCgnaBYi3Qw3g@mail.gmail.com>
In-Reply-To: <CAK8P3a2u=WtQ_98F2934QEZM19YaDPkfzQzHoiCgnaBYi3Qw3g@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 6 Jan 2021 23:00:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3E=+SnbAR=7B_DHX38FY5S=+HjSHpkzTdGWkJKOQ3kHg@mail.gmail.com>
Message-ID: <CAK8P3a3E=+SnbAR=7B_DHX38FY5S=+HjSHpkzTdGWkJKOQ3kHg@mail.gmail.com>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
To:     Will Deacon <will@kernel.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 6, 2021 at 10:04 PM Arnd Bergmann <arnd@kernel.org> wrote:
> On Wed, Jan 6, 2021 at 6:22 PM Will Deacon <will@kernel.org> wrote:
> > On Wed, Jan 06, 2021 at 01:52:53PM +0000, Russell King - ARM Linux admin wrote:
>
> I tried the Image-5.9.0 on a virtual machine with seven CPUs (two clusters)
> running in an M1 mac mini and ran these commands inside.
>
> > With that, I see the following after ten seconds or so:
> >
> >   EXT4-fs error (device sda2): ext4_lookup:1707: inode #674497: comm md5sum: iget: checksum invalid
> >
> > Russell, Mark -- does this recipe explode reliably for you too?
>
> Negative unfortunately -- no checksum mismatch so far, with 10 minutes
> elapsed. I'll keep it running a bit longer.

I managed to trigger the checksum mismatch once now, after around 40
minutes, with a second run going for 20 minutes without mismatch.

So it's not easily reproducible for me, but it does help to rule out
at least some of the hardware specific theories -- it's not just the
Cortex-A72, nor the CCI doing something weird, as neither of
them are in use here.

This is the output I got:

EXT4-fs error (device vda2): ext4_lookup:1707: inode #1185501: comm
md5sum: iget: checksum invalid
Aborting journal on device vda2-8.
EXT4-fs error (device vda2): ext4_journal_check_start:83: Detected
aborted journal
EXT4-fs (vda2): Remounting filesystem read-only
EXT4-fs (vda2): Remounting filesystem read-only
EXT4-fs error (device vda2): ext4_journal_check_start:83: Detected
aborted journal

      Arnd
