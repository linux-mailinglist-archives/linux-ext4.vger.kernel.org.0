Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AD6370849
	for <lists+linux-ext4@lfdr.de>; Sat,  1 May 2021 19:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhEARox (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 1 May 2021 13:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhEARow (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 1 May 2021 13:44:52 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D805C06138B
        for <linux-ext4@vger.kernel.org>; Sat,  1 May 2021 10:44:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id p12so771554pgj.10
        for <linux-ext4@vger.kernel.org>; Sat, 01 May 2021 10:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=bteLvbdWFmjpY8EDbu1U3LFocxkdcdaEmOWgbjbb3e4=;
        b=Xj78uBm4c4NnxCJZlxp4GtzrG1pmHY8B3wWUNaFXF2RmfVL9vrSMFfeSWynGMRb/zu
         95e/M6La/Ry/riBEMcLqGBrR7HAukcwSj10QDUJc8wt0pgZg6ARJh2AffHUmAUKlcV/+
         22uQERRAnSlVX/2guVplhffT0OvmD4KXY75SgMGTbBvLziDCaf9RlDMD0h4xfHeaGFA1
         vG6NVia+DlMUZ/VWv3VJGC9lHWp53KnqA0Uqw9AUEW47C2YiTo+pVevpkKDY4VIRlrSP
         KI0AjVtYlQk6jt+jaDstc0Q7ftcbWvR2nyUo7UKPLznlCM6O/d548oVlZbhqUxpB9xnh
         0+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=bteLvbdWFmjpY8EDbu1U3LFocxkdcdaEmOWgbjbb3e4=;
        b=Xj+QSn/pIMKOsPBPnroMAuo6iXz0gBWYhIWtsclwLL5s0rj1SyCuKukXN+LWWybERm
         /veu8EJarPnn5XZtmHqykcm5bPIXqjAf2Ukkeei5PFLAOBhu3wZI4CTDHMYcUw1EDugH
         6Z2DRR5PYyAC3F84yif7iWWN4nn2zudM5Rjj2xmJRbbkN5JC8Evq8f2HURTb9L9xiXnp
         9zn8MhKPRG3ad5bKblq+9VgHIBG0FY5su7az4wHz1AR7tmZoFlbnTLio4XCfEMoUUCkH
         nwGClJar37hh0y/d9yZ5aH1GLe3Er7KtqimJgumoHtDlo5BOM6X1wwRdsiRfoZTaNF6W
         Vuug==
X-Gm-Message-State: AOAM530rpghEv78eJheDaebDX1n5oee0Kz2hTf5ydECVL8N/iAhcaAT4
        rW19laIgG4KNBAMlutpoWPOf2A==
X-Google-Smtp-Source: ABdhPJy6kSZSmlyplzOfziRmXT1Ukpj8AQOK9NXRBGPJvhlAoqvNQJKLloqX7XnZ9vYgQOPkxVrHeg==
X-Received: by 2002:a62:3706:0:b029:211:3d70:a55a with SMTP id e6-20020a6237060000b02902113d70a55amr10297092pfa.16.1619891041184;
        Sat, 01 May 2021 10:44:01 -0700 (PDT)
Received: from [192.168.10.175] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id s32sm4998479pfw.2.2021.05.01.10.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 May 2021 10:44:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] fs: ext4: mballoc: amend goto to cleanup groupinfo memory correctly
Date:   Sat, 1 May 2021 10:43:57 -0700
Message-Id: <6E6AEEB4-1FBA-40F1-8328-8E304E68A7C6@dilger.ca>
References: <YI0czH0auvWlU8bA@equinox>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <YI0czH0auvWlU8bA@equinox>
To:     Phillip Potter <phil@philpotter.co.uk>, tytso@mit.edu
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On May 1, 2021, at 02:18, Phillip Potter <phil@philpotter.co.uk> wrote:
>=20
> =EF=BB=BFHi All,
>=20
> Sorry to be pushy (I know everyone is busy) but I've had no feedback on
> this patch yet:
> https://lore.kernel.org/linux-ext4/20210412073837.1686-1-phil@philpotter.c=
o.uk/T/#u
>=20
> Could I please ask for it to be reviewed? Many thanks.

Hi Phil,
I've looked at the patch and it looks good. You can add my:

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Note in the future that it is a bit easier to review (IMHO) if you include t=
he
original patch in your ping email, but not a big deal.=20

Cheers, Andreas=
