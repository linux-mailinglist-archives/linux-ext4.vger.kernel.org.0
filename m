Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE5043C4DB
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Oct 2021 10:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbhJ0IQc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 04:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240840AbhJ0IQX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 04:16:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAC4C061767
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 01:13:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso1502097pjb.1
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Ft1XPxFVIbWJTs4Ecpf/2qUoKof8ssQDsFByWw2TlxA=;
        b=b+TWZuMA3dQsZIvTqQlQzEzzGSp7Z8UP80iKDVUP3dPYfXh+xfxCfsIJx7ibBZvLWa
         6aEqHSo5ZztXCeHBtl0Hux+FMfSTpe3pBUhrhoZ2uGxzb0L+3KiwDh40zCYkKkj1wfbe
         loKf6Ez4dD0WM699a9enAQO5yTXfqU4OoQlSbwHtyrlzNmNvNRtZ1wAqPaD08hZYch9P
         KgLoOoWWvUTpBdbM/4Y9n3e4iKEpPfj/dpE9idriu7bzd4c/2uQAqGeCyNJty1iKvffp
         Y8GqU7D04BxbjHHDEsDiNIfjd7wKy+jHKzSESIFfNjIiJO4pWqcU1gR6IW2WzrMJhH+B
         FWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Ft1XPxFVIbWJTs4Ecpf/2qUoKof8ssQDsFByWw2TlxA=;
        b=Lppp1Dcp7x/1l8dOooaXQ2iIhvtE95/BrsGtTeZ1eacCdkPnuYEGrfoJHPlex0U9jn
         2bsO3xVUi/FO/GIAjeR5KrUfOQn7UNN82yxCHrij71580ve2KGslAzkegyFOyH6P7Y3C
         3o7gE5KNDZzAoyPo7UhFQBjbE5sCdvpKVkyttZUJsj8jPn2MnJHNhmobWwbKD3aWmuZz
         lRB5xNoBHwL5Yy2PJhg6YoXgBGaT9AYMtQ2IgwmW4BTH+OZFT2sH4LUYkiMhjfXQ9iSv
         1C7qBHl8nchckc4YDOdWZ3siIkKqzrJznU1w5pX0CFsudi8+lP8HGV/kPQLdL65K3LV5
         ix4Q==
X-Gm-Message-State: AOAM532lMz92nEUhNdhdlntoZP8LKooG0qxEodz4Zk4QI70O/UwC56ZY
        WXERpAJOKNkvabIZa9dvPZ0hxKFrpMQe/bKTVNU=
X-Google-Smtp-Source: ABdhPJxqTAFdj4xwRybxNDcnBHmxCVpbsb1EBOtYLIzJXgoRflds0tPSzDeltozIwJg7qIkM9OAv2cSCRis8Fzg3XL0=
X-Received: by 2002:a17:903:1110:b0:13f:d25c:eac5 with SMTP id
 n16-20020a170903111000b0013fd25ceac5mr27782561plh.5.1635322438192; Wed, 27
 Oct 2021 01:13:58 -0700 (PDT)
MIME-Version: 1.0
Sender: florentmarois953@gmail.com
Received: by 2002:a05:6a20:1d06:b0:51:c25f:a855 with HTTP; Wed, 27 Oct 2021
 01:13:57 -0700 (PDT)
From:   "Dr. Hamza Kabore" <hamzakabore97@gmail.com>
Date:   Wed, 27 Oct 2021 01:13:57 -0700
X-Google-Sender-Auth: ZMEEp9HYAUYcaJS07ukqcbFtrOg
Message-ID: <CAAHQvRexDycVhRnZ8wTvEvDPsPHWZ2CxjnWCpM6pUn6z9quDdw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

-- 
Hello,

Greetings and hope this email finds you well?

I am Dr. Hamza Kabore, the  chief Medical consultant at a reputable
clinic here in Ouagadougou, Burkina Faso and I have a Patient who
hails from the Republic of philippines but unfortunately is in Coma
right now due to complications from a Cancer disease and she has the
sum of $10.7 Million United States (Ten Million seven Hundred
Thousand) Dollars she wants me to guide you on, so that her Bank can
transfer it to you for charity purposes.

Please, I will like you to contact me on this email
(hamzakabore97@gmail.com) for further details as this is a very
sensitive issue that needs urgent attention from you and I want to
maintain the promised I made to the woman before she entered Coma,
never to betray her by looking for another person other than you that
she choosed and selected for the offer among the people she got their
email contacts in her quest for an honest person oversea to help her
wholeheartedly in handling this project to fulfill her wish.

Best Regards,

Dr. Hamza Kabore on behalf of
Mrs. Sismer Shirley Acojedo
