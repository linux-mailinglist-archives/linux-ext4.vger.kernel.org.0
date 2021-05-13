Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8808437FB21
	for <lists+linux-ext4@lfdr.de>; Thu, 13 May 2021 17:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhEMQAY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 May 2021 12:00:24 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:46893 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhEMQAX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 May 2021 12:00:23 -0400
Received: by mail-pl1-f173.google.com with SMTP id s20so14610427plr.13;
        Thu, 13 May 2021 08:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sC9rS2dsZghLNP4cQrgEl3m85yFLwm9XaohEby3pw50=;
        b=RNxDtndZ2FbFHXEwkwpkMUmEqYt5xX4dC4P0P7Axp6tGYABzi5MeoGO2dbRc3TPFYS
         DZHbl8bDdDPd8ZuuAoNPiw5Hjqj5t9+hwjeRDqDiaMDTrC2vkPF62HF59XEZMc1/4h0Z
         4VEnXdu6rM0IryXkEmqNTkRbUvpBOEpHHVlY/2MVUolz7iWWCeSPWPY5YNke0tZPmmH9
         a+6Fq3ow+RNVw2uV7rPhIWob/GRhPiHEwb4epYSGuQuEGrHBNLp9H3USw96hvqyYh9Ma
         yLznlrnRI/0PpiX+xgu59+MTgSl3uQVreYZ8r0G01KK4bMM/kUbhAYnA1RFIDHT3shB4
         U39w==
X-Gm-Message-State: AOAM531nDQMyK/FaUR/scokeFFtgaUUKLJMMC8kZLTsos5nAkw6CJCbg
        tRPey0kinmAOesqtv41IPnJDSLhYjmkqAw==
X-Google-Smtp-Source: ABdhPJyKQvVPuce3z1l4PmtlSaJD2TKIxNY5wls14OzgkkacwtnJxux5VVxX2A9kPeGYMqj6U7DU/w==
X-Received: by 2002:a17:902:7d8b:b029:ef:8306:6ae7 with SMTP id a11-20020a1709027d8bb02900ef83066ae7mr9036878plm.26.1620921553393;
        Thu, 13 May 2021 08:59:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6dd7:5386:8c63:ccae? ([2601:647:4000:d7:6dd7:5386:8c63:ccae])
        by smtp.gmail.com with ESMTPSA id t4sm2410467pfq.165.2021.05.13.08.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 08:59:12 -0700 (PDT)
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
To:     Theodore Ts'o <tytso@mit.edu>,
        Changheun Lee <nanich.lee@samsung.com>
Cc:     alex_y_xu@yahoo.ca, axboe@kernel.dk, bgoncalv@redhat.com,
        dm-crypt@saout.de, hch@lst.de, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        ming.lei@redhat.com, yi.zhang@redhat.com
References: <CGME20210513100034epcas1p4b23892cd77bde73c777eea6dc51c16a4@epcas1p4.samsung.com>
 <20210513094222.17635-1-nanich.lee@samsung.com> <YJ00g8oBZkduQXIe@mit.edu>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a01ab479-69e8-9395-7d24-9de1eec28aff@acm.org>
Date:   Thu, 13 May 2021 08:59:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJ00g8oBZkduQXIe@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 5/13/21 7:15 AM, Theodore Ts'o wrote:
> On Thu, May 13, 2021 at 06:42:22PM +0900, Changheun Lee wrote:
>>
>> Problem might be casued by exhausting of memory. And memory exhausting
>> would be caused by setting of small bio_max_size. Actually it was not
>> reproduced in my VM environment at first. But, I reproduced same problem
>> when bio_max_size is set with 8KB forced. Too many bio allocation would
>> be occurred by setting of 8KB bio_max_size.
> 
> Hmm... I'm not sure how to align your diagnosis with the symptoms in
> the bug report.  If we were limited by memory, that should slow down
> the I/O, but we should still be making forward progress, no?  And a
> forced reboot should not result in data corruption, unless maybe there
> was a missing check for a failed memory allocation, causing data to be
> written to the wrong location, a missing error check leading to the
> block or file system layer not noticing that a write had failed
> (although again, memory exhaustion should not lead to failed writes;
> it might slow us down, sure, but if writes are being failed, something
> is Badly Going Wrong --- things like writes to the swap device or
> writes by the page cleaner must succeed, or else Things Would Go Bad
> In A Hurry).

After the LUKS data corruption issue was reported I decided to take a
look at the dm-crypt code. In that code I found the following:

static void clone_init(struct dm_crypt_io *io, struct bio *clone)
{
	struct crypt_config *cc = io->cc;

	clone->bi_private = io;
	clone->bi_end_io  = crypt_endio;
	bio_set_dev(clone, cc->dev->bdev);
	clone->bi_opf	  = io->base_bio->bi_opf;
}
[ ... ]
static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned size)
{
	[ ... ]
	clone = bio_alloc_bioset(GFP_NOIO, nr_iovecs, &cc->bs);
	[ ... ]
	clone_init(io, clone);
	[ ... ]
	for (i = 0; i < nr_iovecs; i++) {
		[ ... ]
		bio_add_page(clone, page, len, 0);

		remaining_size -= len;
	}
	[ ... ]
}

My interpretation is that crypt_alloc_buffer() allocates a bio,
associates it with the underlying device and clones a bio. The input bio
may have a size up to UINT_MAX while the new limit for the size of the
cloned bio is max_sectors * 512. That causes bio_add_page() to fail if
the input bio is larger than max_sectors * 512, hence the data
corruption. Please note that this is a guess only and that I'm not
familiar with the dm-crypt code.

Bart.
