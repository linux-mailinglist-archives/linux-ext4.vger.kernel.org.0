Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D171D367D
	for <lists+linux-ext4@lfdr.de>; Thu, 14 May 2020 18:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgENQaB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 May 2020 12:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgENQaA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 May 2020 12:30:00 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2120C061A0C
        for <linux-ext4@vger.kernel.org>; Thu, 14 May 2020 09:30:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q16so133027plr.2
        for <linux-ext4@vger.kernel.org>; Thu, 14 May 2020 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:message-id:date
         :cc:to;
        bh=GgeP3YwALRSLcoY+OOpsGxLoN84K64/Ll491zWqCnnk=;
        b=ACXATSDwUUIojREwmP48LHVRUBP3BGyoEXocmdE5Bt5lnUSmKFigTeS1a/dlcpPJY9
         gYiUwtnOCNU0vHDpzISjMBqUE5AeoF6Qp5yI8mVYpocyDetUHJlYudqW2+PgffF/766E
         YU61rV5GJLfUnfdvootplczofO0/Xd/9PUgifnsjBy5CD2nvUvBk665kTJ3tNwFyX4kR
         vuNYWLl/mL2VFc1Wxiz0jGiz64cbhy+GtQ3ZPND17GOJL1wQGpKKMwjOesSdbq/0P26g
         xOoo1oAesB7IHCjNHawVLPsLlsrei6Hog80SnUjfUd8khZIFSdslOUNQyVyYq0zhWrUu
         KbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:message-id:date:cc:to;
        bh=GgeP3YwALRSLcoY+OOpsGxLoN84K64/Ll491zWqCnnk=;
        b=ISPSvg9W6Dg4xHnmpU/Cut2kYf5+zv7xECe2mhV00C5VaqTytPiEjvfxzaMo9CpBzu
         0adXOVhAyX8iulK3hTLQ/gW7h0KVfGkPMzfmkkm3eAYk12bHOSBxDYyHeSlA1645yz+X
         G3jQQPmB7XZ+3PImgCxkK/WL93v8s2tHuMbrwI8aMlz0bwrw5+E2zFoKhieNIRq8B4xY
         weR9rWbs0ebrqgfJJ58WHtb+QpCGy0ZQytmFy8ADaqUsLIM4DY6aYaiFnVXdQh7CsOpF
         7UOgaKZFz1stEjWeMgNrp23K76Mqe65zTy+eH7uyosdhKol9MYJVvZv8DyooXjJNVc7z
         7q0g==
X-Gm-Message-State: AOAM532MCWxbapS1ZW7cQaJMrqPPdbNVK/6qaICfigkrjQW8EV6dV037
        GUeWIg5WfhymOmORG9nGskMfHukhmUbrrVJF
X-Google-Smtp-Source: ABdhPJyFULh66eazkFc70/zo5RqdNzQaEs5SqBgNgqtfbFDMWbsSPUlGVdIPBv+KLowquCNUlKpxzA==
X-Received: by 2002:a17:902:7e4e:: with SMTP id a14mr1661114pln.329.1589473799178;
        Thu, 14 May 2020 09:29:59 -0700 (PDT)
Received: from [192.168.10.175] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id fu12sm18470807pjb.20.2020.05.14.09.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 09:29:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re:  [PATCH 1/2] ext4: mballoc to prefetch groups ahead of scanning
Message-Id: <0BBE5635-CAAF-4FA9-99B3-B2383940FD81@dilger.ca>
Date:   Thu, 14 May 2020 10:29:57 -0600
Cc:     Alex Zhuravlev <azhuravlev@whamcloud.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

=EF=BB=BFOn May 14, 2020, at 03:42, Ritesh Harjani <riteshh@linux.ibm.com> w=
rote:
>=20
> =EF=BB=BFHello Alex,
>=20
> Few comments to understand the patch better.
>=20
>> On 4/28/20 10:50 AM, Alex Zhuravlev wrote:
>> Together with the patch "ext4: limit scanning of uninitialized groups"
> Where is this patch which says ^^^^^ ?

I think that patch was eventually merged into this one?

>> the mount time of a 1PB filesystem is reduced significantly:
>>               0% full    50%-full unpatched    patched
>>  mount time       33s                9279s       563s
>=20
> Looks good. Do you have perf improvement numbers with this patch alone?
> Wonder if this could show improvement if I make my FS image using dm-spars=
e?

That is hard to say, because the sparse image may not need seeking
when reading the bitmaps. You can test with an artificial delay via DM.=20

>> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-12988
>=20
> Not sure if this is required.

This should be kept, as it i the same as existing Debian or Bugzilla tags.
It contains a lot more detail on history and earlier versions of the patches=
.=20

Cheers, Andreas
