Return-Path: <linux-ext4+bounces-1404-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76442868BFC
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 10:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16BE6B21A88
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 09:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6769C135A6A;
	Tue, 27 Feb 2024 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJF2+Dbp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2839F537F3
	for <linux-ext4@vger.kernel.org>; Tue, 27 Feb 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025438; cv=none; b=kHsmelwG9r/bbAfpHHLANqoE8bz/6EZ4GARbJo/mlmXxFNKEIDEL3OBuRCH5HH9KNhVsmeVcIKIGrZUeYFv86sxP3f6F/oSFd91EwOVoevLZWKx7AueEWqixiD4VAneR2BaHt9m0AP4XmJkwLqZpbW+0dyk9FZVgSPraV0eB5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025438; c=relaxed/simple;
	bh=nj2yHnFQ+uo/AvszXEg+SH6tfnqtd/ozyP2hEU54SL8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IBB4OpLZxDqmbaJE31pgkJBDg+JWp+IY8s/jngz+cuPkfJpyZ6EXBFhx5DVII+b91HvuGVYN8nO25v3xpBcV7bDsH96NOnIxHsog9n4NoMrtcKs8lxR8qzWSWR4v3uL72N93q0vvZTH02zUC06E/NPy7OEqZgTaxRhiGWXLUUw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MJF2+Dbp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412a3903586so15377185e9.3
        for <linux-ext4@vger.kernel.org>; Tue, 27 Feb 2024 01:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709025435; x=1709630235; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=diggtj8WfVHmGY/2jyxXjIr6GbLKJAvO81RCvtP7dCs=;
        b=MJF2+Dbpc6EDbN/n8S3r/hhKk2v4SsATFi0HjO75IROv7Sbx+g/FiMdCqkJ9/aWTkI
         U3mDqeybKeqz3qWMJ8HegbwY0Pyozhe9WgO67SgsLmvQbcBqyY4RfyJN7YyVm1Ifbi6d
         yzj8ILNlZeFiROn5SaSWN6vwX6mSxu4r9wGkIPBAxl3HQ0xLtX8DEFKCwaXoieCXWqCu
         JVXsTTuZFJqzwL/hgdr5vLcs/AWYaCBiPz8GWRpQeGvjPZxB5IukPPcYpnRJMyD7cQsg
         9T0yTbtypq0xAuWTjVhdAy5cdidfy3pUD/h0QBqbx4/htdZ6ZZW9bx+xE/4xTkDQhODK
         RiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709025435; x=1709630235;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=diggtj8WfVHmGY/2jyxXjIr6GbLKJAvO81RCvtP7dCs=;
        b=L4HJFKL+st9CVQVUlHLMpeAGMtP/b+gt88mMvUKAlMsVWnEqqHDjaXlCtFVOs+9/Eh
         fdU7vJhmTGeKFAOD10es7KjUaUvoAuG+zdqYirNYq5JfYqnJ3EUlPoeYbGdEwsJzg+T8
         Uxa5hwv/cczsfClhWzlgPK2Grwn3DJsAJECpS3QgWwYYQQJ6Quwg9mIFqhED9lkPVQtO
         JXCOJxf0TMoRdMB/tAiYI8KfoBwuY/BlstQJsqcovTZEeOSl/xn3uWZ4Q4tMILsLH3mn
         cX5AHVuA0DdOal1tvy/w0/zuUgXUA88kcZb81IaLFM4Fpf7wxuYDymEZ+aIRg7/E7Lt6
         Uchw==
X-Gm-Message-State: AOJu0YwgUeG+kyeLs3z9FqFj2yWbXopOKmACCh1juXUNSUdAeoAT8jDT
	Dxw9M/gmNJ61+MqF2Ukbi2HN4JvCrGWZYSac7b3xyvEfUe/xQ9TcqKUQcj1wLTs=
X-Google-Smtp-Source: AGHT+IEsffzlnfjEvS1AfFSGZ5OnULwmw2+Yx8Y3nPVaNF614kvV93P0X/qNsTFl86hByxR5wNcQJg==
X-Received: by 2002:adf:ecc5:0:b0:33d:282c:af48 with SMTP id s5-20020adfecc5000000b0033d282caf48mr6055317wro.69.1709025435509;
        Tue, 27 Feb 2024 01:17:15 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ay25-20020a5d6f19000000b0033da430f286sm11011148wrb.69.2024.02.27.01.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 01:17:15 -0800 (PST)
Date: Tue, 27 Feb 2024 12:17:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: jack@suse.cz
Cc: linux-ext4@vger.kernel.org
Subject: [bug report] ext4: do not create EA inode under buffer lock
Message-ID: <6e5f8a70-1cba-41fa-98f3-2ef3bcc29017@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jan Kara,

The patch ea554578483b: "ext4: do not create EA inode under buffer
lock" from Feb 9, 2024 (linux-next), leads to the following Smatch
static checker warning:

	fs/ext4/xattr.c:2265 ext4_xattr_ibody_set()
	warn: duplicate check 'error' (previous on line 2255)

fs/ext4/xattr.c
    2232 int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
    2233                                 struct ext4_xattr_info *i,
    2234                                 struct ext4_xattr_ibody_find *is)
    2235 {
    2236         struct ext4_xattr_ibody_header *header;
    2237         struct ext4_xattr_search *s = &is->s;
    2238         struct inode *ea_inode = NULL;
    2239         int error;
    2240 
    2241         if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
    2242                 return -ENOSPC;
    2243 
    2244         /* If we need EA inode, prepare it before locking the buffer */
    2245         if (i->value && i->in_inode) {
    2246                 WARN_ON_ONCE(!i->value_len);
    2247 
    2248                 ea_inode = ext4_xattr_inode_lookup_create(handle, inode,
    2249                                         i->value, i->value_len);
    2250                 if (IS_ERR(ea_inode))
    2251                         return PTR_ERR(ea_inode);
    2252         }
    2253         error = ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
    2254                                      false /* is_block */);
    2255         if (error) {
                     ^^^^^

    2256                 if (ea_inode) {
    2257                         int error2;
    2258 
    2259                         error2 = ext4_xattr_inode_dec_ref(handle, ea_inode);
    2260                         if (error2)
    2261                                 ext4_warning_inode(ea_inode, "dec ref error=%d",
    2262                                                    error2);
    2263 
    2264                         /* If there was an error, revert the quota charge. */
--> 2265                         if (error)
                                     ^^^^^
We know "error" is non-zero.  I'm not sure whether to delete this check
or change "error" to "error2".

    2266                                 ext4_xattr_inode_free_quota(inode, ea_inode,
    2267                                                     i_size_read(ea_inode));
    2268                         iput(ea_inode);
    2269                 }
    2270                 return error;
    2271         }
    2272         header = IHDR(inode, ext4_raw_inode(&is->iloc));
    2273         if (!IS_LAST_ENTRY(s->first)) {
    2274                 header->h_magic = cpu_to_le32(EXT4_XATTR_MAGIC);
    2275                 ext4_set_inode_state(inode, EXT4_STATE_XATTR);
    2276         } else {
    2277                 header->h_magic = cpu_to_le32(0);
    2278                 ext4_clear_inode_state(inode, EXT4_STATE_XATTR);
    2279         }
    2280         iput(ea_inode);
    2281         return 0;
    2282 }

regards,
dan carpenter

