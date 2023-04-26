Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C486EFA18
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Apr 2023 20:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjDZSdR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Apr 2023 14:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjDZSdQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Apr 2023 14:33:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FC75588
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 11:33:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94f109b1808so1423936166b.1
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682533991; x=1685125991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahaEO2iuc0jfMflwh1dK2W0/bDfUgJU7zzEfGmg6HUg=;
        b=GhXwi5ZBNA5UX2BiiXvqLuEx2rqO8Hv9j+fDwGNpELycFjGAjG+lctys83mJ0LyOra
         EQkbHJA4Epy3lB8UyffvOdw/OrT9Heg/lojRX4WRblo31U/Ivx5U+5CyWFoBfQaeKf+D
         H0vDD+Q9oGqqMhZz8wwA3Ubwo3e38tdO2lgZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682533991; x=1685125991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahaEO2iuc0jfMflwh1dK2W0/bDfUgJU7zzEfGmg6HUg=;
        b=IoPqN0mUIKrCLcE7pjIMU0IUq/0gYrA1NxSRal5iZGAxKfbZocOFG5pFVPm6oU7ZcA
         1/ZKcLW2f4x6IU84nSK3QbeRlkAhfES5bqc4BCqXEpzBZd20Nma3g9Oo/OzjeDNEkg9T
         ct6nOgeyXTO5i1Lw7z09aT7YuEP8VBH9UeNfhA2NQKvb4PMxdpcZCBKgNumtzguksHsQ
         fH3ii4yJq9pqJUoYEoL7HPdXbERFUVXBlwXuo+NAujWvIZ2AQQR7XKKp+fdLTgb4ZhAq
         Tk8bbQdqisve6dcgmqrVNHdEWRcFe5QQE2dyPbyNtQqAVBFM9s6a/VMgEsH2p/Ne8v8v
         g3Ng==
X-Gm-Message-State: AAQBX9eCbh759NBbFhy3lG2V56m97lac2HMb+lDA+eWOb4dZfLGexwaQ
        wED3E9co8okQDYIklgBaEGpE64BZUCiNidocG8hbCw==
X-Google-Smtp-Source: AKy350Zms7jW5dWdt3YaJ9H6ZpFTxs3Rtx3sosRMkcjNHnfVUFyuogDbzO3AId7EbRmn17ixeOV45w==
X-Received: by 2002:a17:907:3c11:b0:88a:1ea9:a5ea with SMTP id gh17-20020a1709073c1100b0088a1ea9a5eamr14789325ejc.65.1682533991532;
        Wed, 26 Apr 2023 11:33:11 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id lh21-20020a170906f8d500b0094eeab34ad5sm8512243ejb.124.2023.04.26.11.33.10
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 11:33:10 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bc07so12571098a12.2
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 11:33:10 -0700 (PDT)
X-Received: by 2002:aa7:d309:0:b0:506:7f78:c4cc with SMTP id
 p9-20020aa7d309000000b005067f78c4ccmr18858879edq.27.1682533990350; Wed, 26
 Apr 2023 11:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com>
 <CAHk-=wjXDzU1j-cCB28Pxt-=NV5VTbnLimY3HG4uF0HPP7us_Q@mail.gmail.com> <CAKwvOdm3gkAufWcWBqDMQNRXVqJjooFQ4Bi5YPHndWFCPScG+g@mail.gmail.com>
In-Reply-To: <CAKwvOdm3gkAufWcWBqDMQNRXVqJjooFQ4Bi5YPHndWFCPScG+g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Apr 2023 11:32:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wib1T7HzHOhZBATast=nKPT+hkRRqgaFT9osahB08zNRg@mail.gmail.com>
Message-ID: <CAHk-=wib1T7HzHOhZBATast=nKPT+hkRRqgaFT9osahB08zNRg@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 26, 2023 at 11:22=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Ah, it does do something in the callee, not the caller:

Ack, it does seem to have _some_ meaning for the return case, just not
the one we'd be looking for as a way to find mistakes in the
error-pointer case.

          Linus
