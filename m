Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6226D3F50F4
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 21:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhHWTDA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 15:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhHWTC6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 15:02:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4814CC061575
        for <linux-ext4@vger.kernel.org>; Mon, 23 Aug 2021 12:02:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso115862pjh.5
        for <linux-ext4@vger.kernel.org>; Mon, 23 Aug 2021 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vq24WZbvZaeS/j6ldFMsVI1j+zKK5/FPuVsdEfF/56k=;
        b=TOwz77agxsX/Z6vHOfh3RsJJK/W+1zHnCyvXzIPPHH0ETLgijhzZ2KHfvVbfuBZXUU
         W7RxLzFOomU+omO1e7IJYkHSpOfBocIITKkP0hoCz7hrwaeTv/tHtIBs6v3Qm1cEeE3s
         BYWjlByN+DL2fqSBW2lTF4DMrC4azMiQx3p9eHngsI1+Y3jv87+8I3LNkxBTXJjANr30
         7CEN4njK3Ii27U1oagG8VmxC/Istn9iIJA2ak6hRDgtGP9+kbeGZMFxY8r8X94jb6OyD
         b+D1ylmnZf9dGOEPKHqAEyi5YLYmwJwKoN8RwMIlZbI80xPi4ZwIXBDd+RneAdyVTz/1
         hQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vq24WZbvZaeS/j6ldFMsVI1j+zKK5/FPuVsdEfF/56k=;
        b=QwvNr4kuxjC/Ik+6xAzoAXJnWZeMBMSR8FFps0IW15M3eMx9AC+fh/WRaqii2udYcB
         5kYFj+uUi1pyx2jizPif2A21GcJzLWj+/v+CWEFIk5Ga3ldV4xI74BbR4pXvotdasyzo
         fc610KhZpomTwjZtWuy+9IGr4HNcohBVloPjuBYzBaaux7z6Ckv4xFrqWqc6bBnxTNe3
         mUoWHAAcgKpqegIzaLIedyGoSgy6tBGW4vie5SOF6dYROGoRXuL2HsuTCLiBMrq3GDTp
         CEPXhg50RSIEVRQWKSGSrPC2yhCOf4IjS4/mHzIyb1XO/c7CbowTlk5ZlHr4QUFXSxlM
         QgSA==
X-Gm-Message-State: AOAM531pdu55ohT9uZblBrOKYJtbwAIgLhmdOmjM6NkreT6kLW4HUJbZ
        xGC8Kj1pXG9abpbr0TFPF4/WoPhSWq3OnFAizzhcFw==
X-Google-Smtp-Source: ABdhPJw4ffFVirjni1kbtamzxeZlOeZAU2Wfrl9BJ1rGaHZkFmiEzD+T7HoyhzHN8ZFTf8oDeKzbEe1A35lBSTzbMnU=
X-Received: by 2002:a17:902:9b95:b0:130:6a7b:4570 with SMTP id
 y21-20020a1709029b9500b001306a7b4570mr18038564plp.27.1629745334855; Mon, 23
 Aug 2021 12:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210823123516.969486-1-hch@lst.de> <20210823123516.969486-4-hch@lst.de>
In-Reply-To: <20210823123516.969486-4-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Aug 2021 12:02:04 -0700
Message-ID: <CAPcyv4ifoEi3E65yb3OOwwiY2aMyrSap=e7PohN-5w_K4RgKrg@mail.gmail.com>
Subject: Re: [PATCH 3/9] dm: use fs_dax_get_by_bdev instead of dax_get_by_host
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 23, 2021 at 5:39 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no point in trying to finding the dax device if the DAX flag is
> not set on the queue as none of the users of the device mapper exported
> block devices could make use of the DAX capability.

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
