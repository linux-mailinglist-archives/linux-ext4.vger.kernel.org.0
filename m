Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A18732060
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 21:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjFOTeN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 15:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjFOTeL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 15:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69412949
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 12:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686857602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJ9fh5TisbZKUaORbgtmA89u4YsXzvNQtjxXBV2tisQ=;
        b=cjupLKqLzUuBVNKHObqJnGsRuLuWZDfArEPL4wYgWRJxxrCMyZ47Mb7q136GALwfKNw9Gf
        uAs0Ee1fRyoTiiRH4r53WQKFQTzSEW8i/nsQG3DHT+2bPuzfhxV5gYlsTT45BqKSezt+Z8
        DYeTG87kb8w/ilFWK7eKG+EtT8aAyOM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-eDuznSmOOdyLHrzgwzT6ag-1; Thu, 15 Jun 2023 15:33:18 -0400
X-MC-Unique: eDuznSmOOdyLHrzgwzT6ag-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62ffa1214edso104076d6.0
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 12:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686857596; x=1689449596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJ9fh5TisbZKUaORbgtmA89u4YsXzvNQtjxXBV2tisQ=;
        b=SisqpJ8cKq8gSA/cf9oyLNaojzribzM2AZXXoW/Y/Ckl8+4nSit+VhA4o7mRBRgPI3
         I50shkj+V3XqV9+1UpvM8U7ik/shffXUUDzPChthjoIuLbaU+4cepmM37PYk9tBbAFXk
         L2rlFthAwnDQs0foqOsKeoeEJl/O4Mx8480uEmMtvHGaiMJel1bCY3zYIV3BoaXZspjB
         bVNriaA/5pDhxpo6Se/Gl9IVhQkIiy70WuDBR23niIDOat2gljIigkvTOtM2jXmKXjLg
         Rmv6uaWyerml6QoVmQarGSlVPkq9AF198+tY4hVQWyWysupYqUoWcxsKZymqMdaCCrqI
         FqRQ==
X-Gm-Message-State: AC+VfDx3rr8npz8fThgCZq6YHQIY5NeUTzO4tnaeftLPSZU7gShz3aiw
        lMCzr+na95PUrwNWjuWZ2AL5cd8mMzzTEjnSI859YiLhwguOMC7pLSNfn45pmG0lCk7/W0OvU65
        A7ZDXQEdD3r8yhPfy4K6rAA==
X-Received: by 2002:ad4:5bca:0:b0:5ed:c96e:ca4a with SMTP id t10-20020ad45bca000000b005edc96eca4amr22503022qvt.1.1686857595806;
        Thu, 15 Jun 2023 12:33:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5M13ke+gvL3VoDObxmyNhDkjVrjDagXp/R2MhL92zTstn0T61v6zTXVFTefmODf0p29xAboA==
X-Received: by 2002:ad4:5bca:0:b0:5ed:c96e:ca4a with SMTP id t10-20020ad45bca000000b005edc96eca4amr22503000qvt.1.1686857595549;
        Thu, 15 Jun 2023 12:33:15 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c20-20020a0cca14000000b0062ff47845fcsm719203qvk.48.2023.06.15.12.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:33:14 -0700 (PDT)
Date:   Thu, 15 Jun 2023 15:33:12 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     jgg@nvidia.com, david@redhat.com, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
Subject: Re: [PATCH v9 02/14] mm: move page zone helpers from mm.h to mmzone.h
Message-ID: <ZItneGX+sqg7WApF@x1n>
References: <20220715150521.18165-1-alex.sierra@amd.com>
 <20220715150521.18165-3-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220715150521.18165-3-alex.sierra@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello, all,

On Fri, Jul 15, 2022 at 10:05:09AM -0500, Alex Sierra wrote:
> +static inline enum zone_type page_zonenum(const struct page *page)
> +{
> +	ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);
> +	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> +}

Sorry to hijack this patch - not directly relevant to the movement, but
relevant to this helper, so maybe I can leverage the cc list..

My question is whether page_zonenum() is ready for taking all kinds of tail
pages?

Zone device tail pages all look fine, per memmap_init_zone_device().  The
question was other kinds of usual compound pages, like either thp or
hugetlb.  IIUC page->flags can be uninitialized for those tail pages.

Asking because I noticed it seems possible that page_zonenum() can just
take any random tail page as input, e.g.:

try_grab_folio -> is_pci_p2pdma_page -> is_zone_device_page -> page_zonenum

I'm worried it'll just read fake things, but maybe I just missed something?

Thanks,

-- 
Peter Xu

