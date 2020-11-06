Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C05D2A9C79
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 19:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgKFSi6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Nov 2020 13:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgKFSi4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Nov 2020 13:38:56 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CF4C0613D2
        for <linux-ext4@vger.kernel.org>; Fri,  6 Nov 2020 10:38:56 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id a15so414762otf.5
        for <linux-ext4@vger.kernel.org>; Fri, 06 Nov 2020 10:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxHuRb9btK6fIk12CKU8DqhKvsu/vUJtkdyol4DJ8ic=;
        b=XIn0aYLWh5cfYI8YC8hnnl+xITpJDnJfsx1CLbBNUc+eCZZd57DKArsvW7NDUqVSt1
         LheCTXJR5A2xA9YYkLBgHiNAFh0oWTUTNf3j6wEN6ZsXKsOSbE4ZvTs4h+FpXAIFXeyt
         Pmij+rPN/c2LZwrq9SM4W6hND4HiVPfiI1cD2ERzy6Hd5GJ0fd6CkwQh6r5w/2ZwMTTA
         +S5xw1FmFZmLSVBxFCRBcLTSF6cmUwmsKCL10xkwBZNcb2q3Lm+IkI5xlJn62nAxiMJP
         xd/L4tYnn0i3ENSMpCo5fGMt6h5HbECCZK40m4p9ZJuA+34kehcoRo8kdBykFutyedKG
         8YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxHuRb9btK6fIk12CKU8DqhKvsu/vUJtkdyol4DJ8ic=;
        b=MUIvb1peUP52vWQH+lp9cG872S5sTwcrbIfC/CSJA03WMVTxTKkp6OOFFjsBxEHpbg
         Cml1aVb/nMHbjn25K2NE3tKeHwWJu+13daxYWxQzm1lbUJUnpl+qHrNZncD0ONKAXRMB
         bcyVBJ4XYp0I3nRcwPu+BP0finySC2vOboH5LR/xP1IoWpSDJxL8txOEY/9zLROofptT
         rpMW7d6gK5eBJiH+Ih5ZbcEuEN07kB/+1U2g1gqCnsZEaOa6yr1fN6rzvp6cqPypZfPt
         q7ugJbbP165lZcs2uIPI+M/H60c2Mo/ygLraNe+6WtgxmAfTTyrsQIco2+37f4jdba1w
         PCHQ==
X-Gm-Message-State: AOAM530UraV0jRFlQuRM5nPcXVos8rVq/IzPVUS1mlxNABPvZllRrElH
        pep3xMGZody7orj5nFQJ6xbHFaOMCcf0NSmVdCkH3w==
X-Google-Smtp-Source: ABdhPJxNcc3J7eTwqEeCUsfredQHDe3wiEWZuB9t+2mZJN3+7jqYuEo+q+e2qHzI5HQK1c1ykKTjqQ8tIuyGLvZ7mOQ=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr1849209oth.251.1604687935680;
 Fri, 06 Nov 2020 10:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20201106182657.30492-1-98.arpi@gmail.com> <20201106182850.30602-1-98.arpi@gmail.com>
In-Reply-To: <20201106182850.30602-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 6 Nov 2020 19:38:44 +0100
Message-ID: <CANpmjNP4+ByVyabqiDy1KW94XBEMG3j4jqugY3kN+C-w1kEVhA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 6 Nov 2020 at 19:29, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> Modify fs/ext4/inode-test.c to use the parameterized testing
> feature of KUnit.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> ---
[...]
>  fs/ext4/inode-test.c | 314 ++++++++++++++++++++++---------------------
>  1 file changed, 158 insertions(+), 156 deletions(-)

Acked-by: Marco Elver <elver@google.com>

Thanks,
-- Marco
