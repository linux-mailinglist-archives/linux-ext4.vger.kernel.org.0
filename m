Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9A537FFB9
	for <lists+linux-ext4@lfdr.de>; Thu, 13 May 2021 23:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhEMVT2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 May 2021 17:19:28 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:42497 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbhEMVT1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 May 2021 17:19:27 -0400
Received: by mail-pl1-f175.google.com with SMTP id v13so15048931ple.9;
        Thu, 13 May 2021 14:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mvZf3JNCBPnJCp6W7ETlVadxetawitWuzaHn0wwc8uQ=;
        b=m+BERp7WpecMgXSUo2TqCeMMhexujZybqwtaJl5bIibPHVygfFECcd9NcP+pMJlzSc
         v/g6lHBNP52HfgTrDqAbpZ2TWfGVOEVUU6HaCPc+N/Bu149Vm8OanAoIxTGeIoDjRPPJ
         dts1k6x5x/AWeSizxRYXxEY5J6sacxvRF0OU/wHTaqw58l02/uBt0P1/MJceCx7jSO7p
         dNYeltKVzKL3wtp+JnqBCqk98JG5b7SlY9TWO8uYFN6WpDD3bSY+Qz/fYevQsxrRH+vw
         tGYZ4DTwpXfsblGeBmzhbJyJSqh9nquu1ND7DsomFMZ7gmOjtsb9i9fL1q7fVsRRC4Fp
         W5IQ==
X-Gm-Message-State: AOAM531i+nuGrJ9JnpsSrjuGUk1cpjzhYSzZVYpYyjW31jKMvTla8wg8
        IXmnHkc7ybpGnjr5bscy98uEL2UApiAJrg==
X-Google-Smtp-Source: ABdhPJwewpa0foiOfv5+uWT766FJFkGKaXiL58aPMNLdz8Z3MaXuEV5io4OkQpitS3h5OFIBnffzhg==
X-Received: by 2002:a17:90b:84:: with SMTP id bb4mr6992032pjb.60.1620940697238;
        Thu, 13 May 2021 14:18:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:54a8:4531:57a:cfd8? ([2601:647:4000:d7:54a8:4531:57a:cfd8])
        by smtp.gmail.com with ESMTPSA id l35sm2809109pgm.10.2021.05.13.14.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 14:18:16 -0700 (PDT)
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Changheun Lee <nanich.lee@samsung.com>
Cc:     alex_y_xu@yahoo.ca, axboe@kernel.dk, bgoncalv@redhat.com,
        dm-crypt@saout.de, hch@lst.de, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        ming.lei@redhat.com, yi.zhang@redhat.com, dm-devel@redhat.com
References: <a01ab479-69e8-9395-7d24-9de1eec28aff@acm.org>
 <0e7b0b6e-e78c-f22d-af8d-d7bdcb597bea@gmail.com>
 <alpine.LRH.2.02.2105131510330.21927@file01.intranet.prod.int.rdu2.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <fdee795d-7a4b-9506-b9ca-359b9bcbec34@acm.org>
Date:   Thu, 13 May 2021 14:18:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.2105131510330.21927@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 5/13/21 12:22 PM, Mikulas Patocka wrote:
> We already had problems with too large bios in dm-crypt and we fixed it by 
> adding this piece of code:
> 
>         /*
>          * Check if bio is too large, split as needed.
>          */
>         if (unlikely(bio->bi_iter.bi_size > (BIO_MAX_VECS << PAGE_SHIFT)) &&
>             (bio_data_dir(bio) == WRITE || cc->on_disk_tag_size))
>                 dm_accept_partial_bio(bio, ((BIO_MAX_VECS << PAGE_SHIFT) >> SECTOR_SHIFT));
> 
> It will ask the device mapper to split the bio if it is too large. So, 
> crypt_alloc_buffer can't receive a bio that is larger than BIO_MAX_VECS << 
> PAGE_SHIFT.

Hi Mikulas,

Are you perhaps referring to commit 4e870e948fba ("dm crypt: fix error
with too large bios")? Did that commit go upstream before multi-page
bvec support? Can larger bios be supported in case of two or more
contiguous pages now that multi-page bvec support is upstream?

Thanks,

Bart.
