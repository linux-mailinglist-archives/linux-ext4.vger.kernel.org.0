Return-Path: <linux-ext4+bounces-984-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CA283EC5F
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 10:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3391F22D40
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 09:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4241EA90;
	Sat, 27 Jan 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtH5T7sl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF31EA72;
	Sat, 27 Jan 2024 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706348655; cv=none; b=L39QJTVDszdyoi9jhRcdOH3E87KGjZa6KCuh3OsAP5fgDh1UFhVrpNt3udSiHxfGki11i+dZoRKwhjpiGdNolnz312nrCrBA6APNFfK3iGXsNMwzJEB18ZlSjBudsR5wh7AlUNUxP196/sJyu4VEtQOcsv02vOtteO6UthsoFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706348655; c=relaxed/simple;
	bh=kVhSTIelyXWQSAD16/k9ltTCONBkMFXBG2lAiytbs0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F8DZKUml4V6myUsTlwz8QegQtjr89NEDnz2dYqGnzM7qW67bvG+CJVwcTyuYiCedI2poR6HSz2f0zAThwmU4Mqz1PxinGiwx9qPWERrTgPJf6XLthXpZNF90+aPOAiOcB4y432qDGREynn8tW1aR71fiDV5/QiGg5EC7eEo9Szg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtH5T7sl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so233216866b.1;
        Sat, 27 Jan 2024 01:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706348652; x=1706953452; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFZ75ouhCuL4FL5l9x6XpSxnz3lxAM7P5KjxjfPpp9A=;
        b=DtH5T7slxkCn4PbIDOWmX9xGtnhlu53UHDcLZi2uLFeVEdF8iQ4SgYM8LnFSDoNMUL
         6morIpj3bjFWQf9mYC8eHVLcoG94oa5ATftW6E5OEPX8gnNdVcPrmJcvg8gc22qk6aG7
         ojkfJvCUkF9sV+DPAKHrIJYOOHrG6aKnakGvscsD8OVtrQ5kNO6D1Ug8DiwCqkknZ+aj
         jkSiYQPRYHHk4liEVUOGgKSMjxaB1iZWQrF2hfy7/oNAfcnxuD0iw5rnK9GYyK17G5Dr
         6cVT4qDxiisDEqjwpcIOt1YOoM5yIl+r2CHr/rsRmUYpiNVSMDz9sxHMLDundv3of8lg
         JDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706348652; x=1706953452;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFZ75ouhCuL4FL5l9x6XpSxnz3lxAM7P5KjxjfPpp9A=;
        b=vH72iupAgReTPPkZHR0IOsrM9qnswl9GxnKZ7qXkbPGWYekCIRLTe14e1SOx59QSb0
         FV2o81qMUn93Rv6M8wi3if6IBHvYt4VUYarIDLgXyg2zJ/G91CTtZxgAXes9yKCZicPF
         8TSZBjwWvgxRWxmCDwE4ahNN8lgdu99MVbScHhb2N9CY8yIDLtAqrPgFWMUociacwiC5
         YIAJJ9qL27mu3VSPw4A36Fsf+d01UfOo3KUrKzgcmuQIMgNdXTbb78+kkAhmX+wyrX3E
         AcaFoHmtnKUVYJaeylvdb/cqF65MGCobo6GbY8BB8NfcJvXK75cNONkVBJPzi3XrvZUv
         eJ4Q==
X-Gm-Message-State: AOJu0YzWSpNV/0M47cmppUKF5zaDDIdUzqrfTcuEMdpsdbjBZQzY3U/0
	Z7TRzgWd2Y6SdhW2KYeiRPkMB8MCLpxdGXj6n57cMx3IsMGFRH4=
X-Google-Smtp-Source: AGHT+IGiBz7XuACqA5jXtmKZoQFp05laCXLvwI+W8njZBvDB0LUEXwv6iAykP9L8dI9Savi+E4rPBg==
X-Received: by 2002:a17:907:a0d3:b0:a35:278:1c23 with SMTP id hw19-20020a170907a0d300b00a3502781c23mr3487263ejc.35.1706348651715;
        Sat, 27 Jan 2024 01:44:11 -0800 (PST)
Received: from p183 ([46.53.251.60])
        by smtp.gmail.com with ESMTPSA id sf5-20020a1709078a8500b00a353bfdd411sm497828ejc.59.2024.01.27.01.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 01:44:11 -0800 (PST)
Date: Sat, 27 Jan 2024 12:44:09 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 1/7] ext4: avoid overflow when setting values via sysfs
Message-ID: <1da0649d-812f-4dee-9c1b-af567afa2e46@p183>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Baokun Li wrote:

> @@ -463,6 +463,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>  		ret = kstrtoul(skip_spaces(buf), 0, &t);
>  		if (ret)
>  			return ret;
> +		if (t != (unsigned int)t)
> +			return -EINVAL;

kstrto*() interface has variants for all standard types.
It should be changed to kstrtou32() or kstrtouint();

If you check if kstrto*() result fits into another type,
you're probably doing it wrong.

>  		if (a->attr_ptr == ptr_ext4_super_block_offset)
>  			*((__le32 *) ptr) = cpu_to_le32(t);

