Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF003FFA73
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Sep 2021 08:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbhICGfP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Sep 2021 02:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhICGfO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Sep 2021 02:35:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC1FC061575;
        Thu,  2 Sep 2021 23:34:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q3so2710880plx.4;
        Thu, 02 Sep 2021 23:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eUpW6d6s4oHd6jmEUW6QkIvZXo5st+Kpg9QF8HRR6rA=;
        b=NzBBjCS2po1yKEWQe9R3DFWucJ8vaHvVzkcZxE0ZmQ0fd/eDTVYnpTR1N38OnH7toZ
         f5kxVgPPhTXyMHvnt1sTLI+SxlPMHKIKxW4q/FOee+04P4EOSaJl9+617st3bzbLa4rv
         wOyQKC99XyT5F4jLGJNFz6XjB7d/I2bwnK+lVS3RM9ZX9YOSxC7pIuxaaKD/VVDiclHm
         4sLp9x4mONgT0hZQQ00PaT8dQaC/OjCKaCBaCncikt4UkW7aGlPvFC9f3ohwy7H/Czem
         JCv6Nknt3/alnGJRRuxnRWiVFijF/LhMiSu68aoEm9FyGclHcXGgk+KS0OtANbtM2cXO
         ctOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eUpW6d6s4oHd6jmEUW6QkIvZXo5st+Kpg9QF8HRR6rA=;
        b=UZWBrjeNlWm0+ssfWw4Zm3wRhFj0LSVbhxz+nUYoqJ7eAL1aKNAV0a/rFrTBQ/0eul
         XnAnsuEl829hqpHfQ/EuhjbHYjlOCrj9NCf13OBkR/h4EPhPDJdmFJKinoVz0I2cpNXG
         f4Xyi8GHRzHppJRjxLyCROjZKfLh/YypOc9/XpzbjecE6Zhz07qoc0Vmj1bmoLlR9Rk7
         b5P0uzSimEV1SXpDeCFk9hbNaopqU3/ey1DPQfVcGSuadEgav3FXe5OKLl/Bwv2py2I9
         XsLHy8uvhWwYS6Mf4SAeN0okdOyd1TaRFYehhsH4/1Oew/1Vsv9wPZAXZupmb7QXddIf
         bVrA==
X-Gm-Message-State: AOAM532V0DAZAPgTfbqBJiF4jjeto7DRNYlofA2wgog/yiDMFYngKMKS
        ZSRlRDCK/u8xXJ9JQdRxKb8=
X-Google-Smtp-Source: ABdhPJylv6eQkhn7qf8RRjJAu5/K5uzb3Fmf9xZsCCgnKOhMu5PInhG6oSWMHNthoC0SH27MRZalCQ==
X-Received: by 2002:a17:90b:3a8e:: with SMTP id om14mr8418298pjb.192.1630650854496;
        Thu, 02 Sep 2021 23:34:14 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x10sm4482508pfj.174.2021.09.02.23.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 23:34:14 -0700 (PDT)
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     jack@suse.cz, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        Akira Yokosawa <akiyks@gmail.com>
References: <20210902220854.198850-2-corbet@lwn.net>
Subject: Re: [PATCH 1/2] ext4: docs: switch away from list-table
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <b1909f4c-9e07-abd7-89ee-c2e551f9dc5b@gmail.com>
Date:   Fri, 3 Sep 2021 15:34:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902220854.198850-2-corbet@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jon,

On Thu,  2 Sep 2021 16:08:53 -0600, Jonathan Corbet wrote:

> Commit 3a6541e97c03 (Add documentation about the orphan file feature) added
> a new document on orphan files, which is great.  But the use of
> "list-table" results in documents that are absolutely unreadable in their
> plain-text form.  Switch this file to the regular RST table format instead;
> the rendered (HTML) output is identical.

In the "list tables" section of doc-guide/sphinx.rst, the first paragraph
starts with the sentence:

    We recommend the use of list table formats.

Yes, the disadvantage of list tables is mentioned later in the paragraph:

    Compared to the ASCII-art they might not be as comfortable for readers
    of the text files.

, but I still see list-table is meant as the preferred format.

If you prefer the ASCII-art form for simple tables, you might need to
de-emphasize the above mentioned recommendation as well.

        Thanks, Akira
