Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034C03DDDFD
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Aug 2021 18:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhHBQw1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Aug 2021 12:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhHBQw1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Aug 2021 12:52:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762AFC06175F
        for <linux-ext4@vger.kernel.org>; Mon,  2 Aug 2021 09:52:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y34so34881407lfa.8
        for <linux-ext4@vger.kernel.org>; Mon, 02 Aug 2021 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=IJ28+rK9CXy74t9PYra9/nF/GakZDV4ZOl7bejGECk8WvUmdOf9Zwspgrvxg99uDea
         pnBvsMKXjbEviraNg0JOOQbPjvCWdfKP0/y3zeyFEHTzOsM2YyoJy9+AMBM12me3p4Zg
         r/Wbk65r6eYV91MDnLtd8Fa8zU9XiIJDQD7wQOGuPot+dIRf5uwM1RoZzhxte4ua+bfE
         9I4PKP72ZH/Me2ty3o2M9QNGnUXPE39DR6DNbmLDQu71TFNCIhtU+l9dNVA09pmQc+Jh
         jZwvzUlPlmFGEbvTbTFzZEgGDcSBM6Ay8zH7jXh8nyjIGvXrwrKt5XQv6HSlGeiht7gb
         +cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=qSnz2GmIVpyA5Koy/Pe2mj29n7xVmi7MQQL8mEU7xMxH1HEN3BDv1IpFraPdicUsqo
         Bizi+G+Al1rRj5xk+cWSCwFfRrCuawwER7O6vrifqTBB7bnQMmL4sR0W5p/0doFJCI9k
         54OVrnBpvZTcNxuxWvlTUl+IqQqEH9MdzPrr6oaHf8TQrTiMBkxs7wzzP5hk9cJqDWGR
         EyxKgNTpOSBZwJX2hbOP1Q4ONGc+U18ClWFIJDJEbSm6MD8Nl6+ZkFCL7srI/2/009Qc
         H2vqvflrb0QxzOzYs0Y+14U6gW5A4bwYLTCS16wuoo1NdR7616GJKJHUXJVSVGWIHcup
         galw==
X-Gm-Message-State: AOAM5318lI71VXH9MSL7VN+5q8DNTnZg9E+Jgstt7cXQIQ+MncNg2BJl
        d7oUX9GM4/RdIgrlRTNXNvwIEzu7lekJML3blNI=
X-Google-Smtp-Source: ABdhPJxTB6ov3FqHT+008QYiFGzHna4AqaZyAXmUF3B/nuZvpZotuaRjkOZs5cuHgDNDgHHgnenutR3H0cFDQhtbukc=
X-Received: by 2002:ac2:4ec3:: with SMTP id p3mr12897103lfr.556.1627923135717;
 Mon, 02 Aug 2021 09:52:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:51d4:0:0:0:0 with HTTP; Mon, 2 Aug 2021 09:52:15
 -0700 (PDT)
Reply-To: fms333166@yandex.com
From:   Frank Martins <martinsandpartners.tg@gmail.com>
Date:   Mon, 2 Aug 2021 09:52:15 -0700
Message-ID: <CAKBT9ERw2Q+0BWBw_r4iU+s0qwGsitedz0krZscarqXs29mtqw@mail.gmail.com>
Subject: =?UTF-8?Q?Ich_warte_immer_noch_auf_Ihre_Antwort_auf_meine_zahl?=
        =?UTF-8?Q?reichen_unbeantworteten_E=2DMails_an_Sie_bez=C3=BCglich_Ihres_Fami?=
        =?UTF-8?Q?lienerbschaftsfonds_=288=2C5_Millionen_US=2DDollar=29=2E_Bitte_best=C3=A4t?=
        =?UTF-8?Q?igen_Sie_mir_diesen_Brief_f=C3=BCr_weitere_Details=2E_Gr=C3=BC=C3=9Fe=2E_Mit?=
        =?UTF-8?Q?_freundlichen_Gr=C3=BC=C3=9Fen_Herr_Frank_Martins=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


