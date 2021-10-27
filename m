Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68D143C294
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Oct 2021 08:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhJ0GNd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 02:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhJ0GNc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 02:13:32 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D125C061570
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 23:11:07 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id i14so2223730ioa.13
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 23:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqwaGiTpzQBE07WRbVBGvjb01yKJSD6j1sWmM16zRSg=;
        b=JgOgf5hcNhpRL9tnTailOk1lpbZcRs0t2yssc+1//VDrQOeh9wpXS5kJ+MDkJIPvk+
         P3tXhTv8tX80udsa17JfPX7O1VxLW5tSx7INFOG7b41/qTdNWSoAP8yWxHeQfJ8tBTX2
         t4maWlUYkED5JFWxH6h2PZgFZ7mpyd+rG5BTztC7PLHY4jkluYPns49ODbv5i414m593
         WAEMNt3LHrlq0rFuBJqwXKiNBArEZ1whXf26y7l3B+P5xZDREGI0cDDxHkhabtc0UqpF
         Acuvn39naiSVP4/2ufXaiSKh5SZzLikI2HvD7HhevJDFH0Cx90W8lur5zyKHvETxBM82
         IGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqwaGiTpzQBE07WRbVBGvjb01yKJSD6j1sWmM16zRSg=;
        b=NdQjANXbrILj1jgPGFF872mKhZhtams4tmAoolo9OjXaWrkxOmolUllupLu+ACUpL/
         crrmZgBxvOpg/hESYj+O3B8HbXHyK1k/fdbv4UcwQr1THz5sBDxCxKwmyayd9t7KKAZf
         62WqiI1uK9F/EeCPVg6yxD41AKV14k9L0Ac4np9vsnMxM7a0gjV8dDXFIlwdyJDvXzgj
         QrK/iOgE910NxMnoEjcUyfHlZ0jhjue5fUqoZpl0lUrrJqJUXx2Euxdy6GGgvL8rckEk
         k9r7AJ04upKs7P1gSjU11ipTw2H7JReLfM1F01lTojlIdZq00vEK2uk2LZMAtH7iFG/E
         fnvQ==
X-Gm-Message-State: AOAM533WmPJ+iYzSD9krP2B5rjCnr1PDK/rW1p3ldcElKaEYixiXLmXm
        br57TinYMFupG6gb60/nt4tUX49vFtBDn+jjjUA1/hRLiSw=
X-Google-Smtp-Source: ABdhPJz/kkv/EWi6r/D4S7PT9bYM43ovca5FpB7VwlgVaJc4ZHGp39Y0fwcxosXffF8lVjG3k488ty5rsD1AM9G/zzY=
X-Received: by 2002:a05:6602:2ac8:: with SMTP id m8mr19102149iov.112.1635315066947;
 Tue, 26 Oct 2021 23:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com> <20211026184239.151156-2-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-2-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Oct 2021 09:10:56 +0300
Message-ID: <CAOQ4uxgPM=D4_5ky=uADSFBFXOXia8A+XCabC3tF5wq1FmKQuA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] syscalls: fanotify: Add macro to require
 specific mark types
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     LTP List <ltp@lists.linux.it>, Jan Kara <jack@suse.com>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com,
        Ext4 <linux-ext4@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 26, 2021 at 9:43 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Like done for init flags and event types, and a macro to require a
> specific mark type.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index a2be183385e4..c67db3117e29 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -373,4 +373,9 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
>         return rval;
>  }
>
> +#define REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type) do { \
> +       fanotify_init_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
> +                                   fanotify_mark_supported_by_kernel(mark_type)); \
> +} while (0)
> +
>  #endif /* __FANOTIFY_H__ */
> --
> 2.33.0
>
