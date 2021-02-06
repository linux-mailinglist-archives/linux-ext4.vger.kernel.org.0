Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1368311DCA
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Feb 2021 15:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhBFOjF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 6 Feb 2021 09:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhBFOjD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 6 Feb 2021 09:39:03 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262AAC06178A
        for <linux-ext4@vger.kernel.org>; Sat,  6 Feb 2021 06:38:23 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id k142so10772600oib.7
        for <linux-ext4@vger.kernel.org>; Sat, 06 Feb 2021 06:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=K2d4+17Q4nUcrDmnpwnXEM3emFYl+RuFoeVGRPmGycCmRVt3HN5Z96RmeqMPcJ98Ju
         xpuL8BnuBaTTUxvCJm3nNLya0K/pjfYnO9eC4jsTzxsO7/tR/BOIVhb6bzS34eHj0rbk
         w5POS1fsotS2po2NsqZfLZeV9/RRpw+AuAOXU6ls3U1Q1f6j0u7W+jzkRSygJgFfoUjy
         v6uQ1z2lTxEbSaM8B80cJ8jmtHlDtecavxr5w9ZgcopCMC9qZi8PVAlM8QuriDjL3jZg
         CuQyVMStRabU3XzDJbpobMmWrieb8BWdKnpkxpVPeDQ8goeCOSCGuDAefIANvpwmoPnK
         DRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=rucXHwSoq4HRCFLc+iyUK+409FqHdyZ5Ti6NjMkbl07qTLZODsfsBRR7Ieep5i931C
         HDetvj1tmE7ftuyniKYl6xSIEa++KgR59XGLt7c/up7RhCIZRmqbNozndvac0rAjsFIe
         69ORG206FtMDaKLBQUTHtD6P7eWp1kBsTmFX9h8T+fFsca0poSH8a3DlEK5Akxgnpyig
         iI6k7sBi2eyCndtf9Ji00m2jA9z8IPX2FGeOPfGcyMRLUEGDDs1msB8d8h2LzLSK5iRa
         SE+mWmPkS2xGJQ2+tMovsj5ziqPwE5QvPfsqEC8R/VCqUak/MR/gT9ga8XHQBFUgIFCw
         qxnw==
X-Gm-Message-State: AOAM530dyh1yntm+c565blT1OnPRHOdyCmZ7+Z/MdLy3lxGPtlK99fAD
        9e9hTVmFAOZ/K6iHmd+7bqJXCzAjMD4M2hh9kRY=
X-Google-Smtp-Source: ABdhPJw6jpWGBROucdqWQ6GMIvTki4A6jUK6Uh9IA0paB7yRz2gOmacCTmFVn4nsvxfz3x5rHc6UNQjVtu8uw8jygVU=
X-Received: by 2002:aca:c545:: with SMTP id v66mr96227oif.116.1612622302631;
 Sat, 06 Feb 2021 06:38:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:3e4c:0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:38:22 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada@gmail.com>
Date:   Sat, 6 Feb 2021 15:38:22 +0100
Message-ID: <CAO_fDi_6i9j8Tbk2Gu2TkA7P3xCjFNBDWH9c6HtMYBTpWuax+Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
